import Mathlib
import BookProof.ChapterSchurGershgorinGap
import BookProof.ChapterSirkCertificateReader

/-!
# Chapter YangMillsCertificateSeam — the certificate→theorem seam for the Yang–Mills gap

`CONSOLIDATED_PLAN.md` (2026-09-04f), QYM next step 2: *"the theorem that consumes
certified matrix-element data (emitted by `GapCertificate.lean` / the NDJSON fixture) and
discharges the Gershgorin tail + Schur coupling hypotheses, giving
`ym_fock_mass_gap_of_truncated_gap_and_matrix_bounds` for the concrete
`qcd_ym_hamiltonian(g)` — never reading a displayed Ritz value as a lower bound."*

`BookProof.ChapterSchurGershgorinGap` already reduces the nested-Fock conclusion to
matrix-element inequalities, but it states them as five separate quantified hypotheses with
*independent* real parameters `mu`, `eps`, `d`, `r`.  A certificate does not emit five
parameters: it emits **one line of exact decimals**.  This chapter is the missing seam.

## What is and is not trusted

* **No floating-point value is trusted, and none is used.**  As in
  `BookProof.ChapterSirkCertificateReader`, a wire-format number is read as an exact
  `Decimal` (mantissa, power of ten), so its value is an exact rational.
* **No numerical claim is verified here.**  What the seam discharges is the *arithmetic*
  side of the criterion — `0 ≤ ε`, `ε < μ`, `μ ≤ dmin − rmax` — from the emitted decimals,
  by kernel-checkable rational arithmetic, and the bookkeeping that turns the two uniform
  tail numbers into the index-wise families `d`, `r` the lift consumes.  The *analytic*
  content — that the recorded numbers really do bound the matrix elements of the
  Yang–Mills Hamiltonian, and that the order-`m` truncation really does have the recorded
  level gap — stays as explicit enclosure hypotheses, exactly as T6/T8 do.  A displayed
  Ritz value is never read as a lower bound.
* Nothing here claims the physical Yang–Mills mass gap.

## Deliverables

* `MatrixBoundRecord`, `parseMatrixBoundLine`, `parseMatrixBounds` — the wire format for
  matrix-element data: `{"m":4,"mu":1.9320,"eps":0.0300,"dmin":2.0000,"rmax":0.0500}`.
* `MatrixBoundRecord.checkBounds`, `MatrixBoundRecord.Valid`, `valid_of_checkBounds` — the
  decidable arithmetic side conditions and their reading as propositions.
* **`ym_fock_gap_of_matrix_certificate`** — the quantitative seam: the certified level gap
  plus the uniform Gershgorin/Schur enclosures give the nested-Fock energy bound with the
  explicit constant `μ − ε`.
* **`ym_fock_mass_gap_of_matrix_certificate`** — the seam in the form the chain consumes:
  a positive-definite nested-Fock energy on the vacuum-orthogonal sector, with the
  Friedrichs extension and the annihilated vacuum.
* `exampleNdjson`, `example_parse`, `example_checkBounds`, `example_ym_fock_mass_gap` — the
  wire format worked through end to end on the recorded `g = 2`, `m = 4` band.

Everything is `sorry`-free and `axiom`-free.
-/

noncomputable section

namespace BookProof.YangMillsCertificateSeam

open BookProof.SirkCertificateReader
open BookProof.SchurGershgorin
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.TruncationGapLift
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain

/-! ## 1. The wire format of matrix-element data -/

/-- One emitted matrix-bound line: the truncation order `m`, the level gap `μ` certified on
the order-`m` truncation, the Schur bound `ε` on the coupling block, and the two uniform
Gershgorin numbers of the tail — a diagonal lower bound `dmin` and an off-diagonal row-sum
bound `rmax`. -/
structure MatrixBoundRecord where
  /-- The truncation order. -/
  m : ℕ
  /-- The level gap certified on the order-`m` truncation. -/
  mu : Decimal
  /-- The Schur bound on the coupling block. -/
  eps : Decimal
  /-- The uniform lower bound for the tail diagonal entries. -/
  dmin : Decimal
  /-- The uniform bound for the tail off-diagonal absolute row sums. -/
  rmax : Decimal
deriving DecidableEq, Repr

/-- The certified level gap as an exact rational. -/
def MatrixBoundRecord.muQ (c : MatrixBoundRecord) : ℚ := c.mu.toQ

/-- The Schur coupling bound as an exact rational. -/
def MatrixBoundRecord.epsQ (c : MatrixBoundRecord) : ℚ := c.eps.toQ

/-- The tail diagonal bound as an exact rational. -/
def MatrixBoundRecord.dminQ (c : MatrixBoundRecord) : ℚ := c.dmin.toQ

/-- The tail row-sum bound as an exact rational. -/
def MatrixBoundRecord.rmaxQ (c : MatrixBoundRecord) : ℚ := c.rmax.toQ

/-- The certified mass-gap constant `μ − ε` carried by a record. -/
def MatrixBoundRecord.lowerQ (c : MatrixBoundRecord) : ℚ := c.muQ - c.epsQ

/-- Parse one emitted matrix-bound line.  Every field the proof consumes is read; a line
missing one of them fails to parse (it is never defaulted). -/
def parseMatrixBoundLine (line : List Char) : Option MatrixBoundRecord := do
  let ms ← fieldChars line "m".toList
  let m ← parseNatDigits ms
  let mus ← fieldChars line "mu".toList
  let mu ← parseDec mus
  let epss ← fieldChars line "eps".toList
  let eps ← parseDec epss
  let dmins ← fieldChars line "dmin".toList
  let dmin ← parseDec dmins
  let rmaxs ← fieldChars line "rmax".toList
  let rmax ← parseDec rmaxs
  some ⟨m, mu, eps, dmin, rmax⟩

/-- **The reader.**  The first well-formed matrix-bound line of an emitted certificate;
lines that are not matrix-bound records are ignored. -/
def parseMatrixBounds (s : String) : Option MatrixBoundRecord :=
  ((splitLines s.toList).filterMap parseMatrixBoundLine).head?

/-! ## 2. The decidable arithmetic side conditions -/

/-- **The arithmetic check** a record must pass: a non-negative coupling bound, a coupling
bound strictly below the level gap, and tail diagonal dominance at least as strong as the
level gap. -/
def MatrixBoundRecord.checkBounds (c : MatrixBoundRecord) : Bool :=
  decide (0 ≤ c.epsQ) && decide (c.epsQ < c.muQ) && decide (c.muQ ≤ c.dminQ - c.rmaxQ)

/-- The same three conditions as propositions. -/
structure MatrixBoundRecord.Valid (c : MatrixBoundRecord) : Prop where
  /-- The coupling bound is non-negative. -/
  eps_nonneg : 0 ≤ c.epsQ
  /-- The coupling bound is strictly below the certified level gap. -/
  eps_lt_mu : c.epsQ < c.muQ
  /-- The tail is diagonally dominant at least down to the level gap. -/
  dominance : c.muQ ≤ c.dminQ - c.rmaxQ

theorem valid_of_checkBounds {c : MatrixBoundRecord} (h : c.checkBounds = true) : c.Valid := by
  rw [MatrixBoundRecord.checkBounds, Bool.and_eq_true, Bool.and_eq_true] at h
  exact ⟨by simpa using h.1.1, by simpa using h.1.2, by simpa using h.2⟩

/-! ## 3. The seam -/

variable (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ)

/-- **The quantitative seam.**  Given a matrix-bound record that passes the arithmetic
check, the certified order-`m` level gap and the uniform Gershgorin/Schur enclosures for
the recorded matrix elements of the gauge-fixed Yang–Mills Hamiltonian, the nested-Fock
operator `dΓ(H₁)` annihilates the vacuum and has energy at least `μ − ε` on the
vacuum-orthogonal sector.

The record supplies only exact decimals; the enclosure hypotheses supply the analytic
content, and no displayed Ritz value is read as a lower bound. -/
theorem ym_fock_gap_of_matrix_certificate (c : MatrixBoundRecord)
    (hchk : c.checkBounds = true)
    (htrunc : ∀ x : finiteModeDomain (coreBasis e),
      (x : L2d 99) ∈ galerkinSpan (coreBasis e) c.m →
      ((c.muQ : ℚ) : ℝ) * ‖(x : L2d 99)‖ ^ 2 ≤ quadForm (ymHamiltonian (coreRepBasis e) fabc) x)
    (hdiag : ∀ i, c.m ≤ i →
      ((c.dminQ : ℚ) : ℝ) ≤ (entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i i).re)
    (hrow : ∀ i, c.m ≤ i → ∀ S : Finset ℕ, (∀ j ∈ S, c.m ≤ j) → i ∉ S →
      ∑ j ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖
        ≤ ((c.rmaxQ : ℚ) : ℝ))
    (hblockrow : ∀ i, i < c.m → ∀ S : Finset ℕ, (∀ j ∈ S, c.m ≤ j) →
      ∑ j ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖
        ≤ ((c.epsQ : ℚ) : ℝ))
    (hblockcol : ∀ j, c.m ≤ j → ∀ S : Finset ℕ, (∀ i ∈ S, i < c.m) →
      ∑ i ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖
        ≤ ((c.epsQ : ℚ) : ℝ)) :
    dGamma (ymFockCol e fabc) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        ((c.lowerQ : ℚ) : ℝ) * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma (ymFockCol e fabc) u)) : ℂ).re := by
  obtain ⟨heps, hlt, hdom⟩ := valid_of_checkBounds hchk
  have hepsR : (0 : ℝ) ≤ ((c.epsQ : ℚ) : ℝ) := by exact_mod_cast heps
  have hltR : ((c.epsQ : ℚ) : ℝ) < ((c.muQ : ℚ) : ℝ) := by exact_mod_cast hlt
  have hdomR : ((c.muQ : ℚ) : ℝ) ≤ ((c.dminQ : ℚ) : ℝ) - ((c.rmaxQ : ℚ) : ℝ) := by
    have : ((c.muQ : ℚ) : ℝ) ≤ (((c.dminQ - c.rmaxQ : ℚ)) : ℝ) := by exact_mod_cast hdom
    simpa using this
  have hlow : ((c.lowerQ : ℚ) : ℝ) = ((c.muQ : ℚ) : ℝ) - ((c.epsQ : ℚ) : ℝ) := by
    rw [MatrixBoundRecord.lowerQ]
    push_cast
    ring
  rw [hlow]
  exact ym_fock_gap_of_truncated_gap_and_matrix_bounds e fabc hepsR (by linarith)
    (fun _ => ((c.dminQ : ℚ) : ℝ)) (fun _ => ((c.rmaxQ : ℚ) : ℝ))
    htrunc (fun i hi => hdiag i hi) (fun i hi => hrow i hi)
    (fun _ _ => hdomR) hblockrow hblockcol

/-- **The seam in the form the chain consumes.**  Under the same certificate the
nested-Fock Hamiltonian has a positive self-adjoint (Friedrichs) extension, annihilates the
vacuum, and is *strictly positive* on every non-zero vacuum-orthogonal state — the
nested-Fock mass-gap statement of `ChapterYangMillsFockGapChain`, now driven by one emitted
line of exact decimals. -/
theorem ym_fock_mass_gap_of_matrix_certificate (c : MatrixBoundRecord)
    (hchk : c.checkBounds = true)
    (htrunc : ∀ x : finiteModeDomain (coreBasis e),
      (x : L2d 99) ∈ galerkinSpan (coreBasis e) c.m →
      ((c.muQ : ℚ) : ℝ) * ‖(x : L2d 99)‖ ^ 2 ≤ quadForm (ymHamiltonian (coreRepBasis e) fabc) x)
    (hdiag : ∀ i, c.m ≤ i →
      ((c.dminQ : ℚ) : ℝ) ≤ (entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i i).re)
    (hrow : ∀ i, c.m ≤ i → ∀ S : Finset ℕ, (∀ j ∈ S, c.m ≤ j) → i ∉ S →
      ∑ j ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖
        ≤ ((c.rmaxQ : ℚ) : ℝ))
    (hblockrow : ∀ i, i < c.m → ∀ S : Finset ℕ, (∀ j ∈ S, c.m ≤ j) →
      ∑ j ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖
        ≤ ((c.epsQ : ℚ) : ℝ))
    (hblockcol : ∀ j, c.m ≤ j → ∀ S : Finset ℕ, (∀ i ∈ S, i < c.m) →
      ∑ i ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖
        ≤ ((c.epsQ : ℚ) : ℝ)) :
    (∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
        IsPositiveSelfAdjointExtension (dGammaOp (ymFockCol e fabc)) A) ∧
      dGamma (ymFockCol e fabc) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 → u ≠ 0 →
        0 < (inner ℂ (toLp u) (toLp (dGamma (ymFockCol e fabc) u)) : ℂ).re := by
  obtain ⟨heps, hlt, hdom⟩ := valid_of_checkBounds hchk
  have hepsR : (0 : ℝ) ≤ ((c.epsQ : ℚ) : ℝ) := by exact_mod_cast heps
  have hltR : ((c.epsQ : ℚ) : ℝ) < ((c.muQ : ℚ) : ℝ) := by exact_mod_cast hlt
  have hdomR : ((c.muQ : ℚ) : ℝ) ≤ ((c.dminQ : ℚ) : ℝ) - ((c.rmaxQ : ℚ) : ℝ) := by
    have : ((c.muQ : ℚ) : ℝ) ≤ (((c.dminQ - c.rmaxQ : ℚ)) : ℝ) := by exact_mod_cast hdom
    simpa using this
  exact ym_fock_mass_gap_of_truncated_gap_and_matrix_bounds e fabc hepsR hltR
    (fun _ => ((c.dminQ : ℚ) : ℝ)) (fun _ => ((c.rmaxQ : ℚ) : ℝ))
    htrunc (fun i hi => hdiag i hi) (fun i hi => hrow i hi)
    (fun _ _ => hdomR) hblockrow hblockcol

/-! ## 4. The wire format worked through

The transcribed datum of the recorded `g = 2`, `m = 4` run (`MASS_GAP_CERTIFIED.md`,
`GapCertificate.lean`) is the certified band `[1.932, 2.043]`, whose lower end is the level
gap `μ = 1.9320` of the order-`4` truncation.  The three remaining numbers of the line —
the Schur coupling bound and the two Gershgorin tail numbers — are **not** transcribed
data: they illustrate the wire format, and the theorems consume them only through the
enclosure hypotheses. -/

/-- An emitted matrix-bound certificate in the wire format.  Only `mu` is transcribed data;
the other three numbers illustrate the format. -/
def exampleNdjson : String :=
  "{\"m\":4,\"mu\":1.9320,\"eps\":0.0300,\"dmin\":2.0000,\"rmax\":0.0500}\n"

/-- The parsed contents of the example certificate. -/
def exampleRecord : MatrixBoundRecord :=
  ⟨4, ⟨19320, 4⟩, ⟨300, 4⟩, ⟨20000, 4⟩, ⟨500, 4⟩⟩

/-- The reader parses the example certificate to the expected record. -/
theorem example_parse : parseMatrixBounds exampleNdjson = some exampleRecord := by rfl

/-- The example record passes the arithmetic check: `0 ≤ 0.03 < 1.932 ≤ 2 − 0.05`. -/
theorem example_checkBounds : exampleRecord.checkBounds = true := by
  rw [MatrixBoundRecord.checkBounds]
  norm_num [MatrixBoundRecord.epsQ, MatrixBoundRecord.muQ, MatrixBoundRecord.dminQ,
    MatrixBoundRecord.rmaxQ, exampleRecord, Decimal.toQ]

/-- The mass-gap constant the example certificate carries is `μ − ε = 1.902`. -/
theorem example_lower : exampleRecord.lowerQ = 1902 / 1000 := by
  norm_num [MatrixBoundRecord.lowerQ, MatrixBoundRecord.muQ, MatrixBoundRecord.epsQ,
    exampleRecord, Decimal.toQ]

/-- **The seam, end to end.**  From the emitted text alone — parsed exactly, no
floating-point value trusted — together with the enclosures the certificate asserts for the
matrix elements of the gauge-fixed Yang–Mills Hamiltonian, the nested-Fock Hamiltonian
annihilates the vacuum and has energy at least `1.902` on the vacuum-orthogonal sector. -/
theorem example_ym_fock_gap
    (htrunc : ∀ x : finiteModeDomain (coreBasis e),
      (x : L2d 99) ∈ galerkinSpan (coreBasis e) exampleRecord.m →
      ((exampleRecord.muQ : ℚ) : ℝ) * ‖(x : L2d 99)‖ ^ 2
        ≤ quadForm (ymHamiltonian (coreRepBasis e) fabc) x)
    (hdiag : ∀ i, exampleRecord.m ≤ i →
      ((exampleRecord.dminQ : ℚ) : ℝ)
        ≤ (entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i i).re)
    (hrow : ∀ i, exampleRecord.m ≤ i → ∀ S : Finset ℕ, (∀ j ∈ S, exampleRecord.m ≤ j) → i ∉ S →
      ∑ j ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖
        ≤ ((exampleRecord.rmaxQ : ℚ) : ℝ))
    (hblockrow : ∀ i, i < exampleRecord.m → ∀ S : Finset ℕ, (∀ j ∈ S, exampleRecord.m ≤ j) →
      ∑ j ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖
        ≤ ((exampleRecord.epsQ : ℚ) : ℝ))
    (hblockcol : ∀ j, exampleRecord.m ≤ j → ∀ S : Finset ℕ, (∀ i ∈ S, i < exampleRecord.m) →
      ∑ i ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖
        ≤ ((exampleRecord.epsQ : ℚ) : ℝ)) :
    dGamma (ymFockCol e fabc) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        (1.902 : ℝ) * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma (ymFockCol e fabc) u)) : ℂ).re := by
  have h := ym_fock_gap_of_matrix_certificate e fabc exampleRecord example_checkBounds
    htrunc hdiag hrow hblockrow hblockcol
  have hcast : ((exampleRecord.lowerQ : ℚ) : ℝ) = (1.902 : ℝ) := by
    rw [example_lower]
    norm_num
  rwa [hcast] at h

/-- **The seam, end to end, in mass-gap form.** -/
theorem example_ym_fock_mass_gap
    (htrunc : ∀ x : finiteModeDomain (coreBasis e),
      (x : L2d 99) ∈ galerkinSpan (coreBasis e) exampleRecord.m →
      ((exampleRecord.muQ : ℚ) : ℝ) * ‖(x : L2d 99)‖ ^ 2
        ≤ quadForm (ymHamiltonian (coreRepBasis e) fabc) x)
    (hdiag : ∀ i, exampleRecord.m ≤ i →
      ((exampleRecord.dminQ : ℚ) : ℝ)
        ≤ (entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i i).re)
    (hrow : ∀ i, exampleRecord.m ≤ i → ∀ S : Finset ℕ, (∀ j ∈ S, exampleRecord.m ≤ j) → i ∉ S →
      ∑ j ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖
        ≤ ((exampleRecord.rmaxQ : ℚ) : ℝ))
    (hblockrow : ∀ i, i < exampleRecord.m → ∀ S : Finset ℕ, (∀ j ∈ S, exampleRecord.m ≤ j) →
      ∑ j ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖
        ≤ ((exampleRecord.epsQ : ℚ) : ℝ))
    (hblockcol : ∀ j, exampleRecord.m ≤ j → ∀ S : Finset ℕ, (∀ i ∈ S, i < exampleRecord.m) →
      ∑ i ∈ S, ‖entry (coreBasis e) (ymHamiltonian (coreRepBasis e) fabc) i j‖
        ≤ ((exampleRecord.epsQ : ℚ) : ℝ)) :
    (∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
        IsPositiveSelfAdjointExtension (dGammaOp (ymFockCol e fabc)) A) ∧
      dGamma (ymFockCol e fabc) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 → u ≠ 0 →
        0 < (inner ℂ (toLp u) (toLp (dGamma (ymFockCol e fabc) u)) : ℂ).re :=
  ym_fock_mass_gap_of_matrix_certificate e fabc exampleRecord example_checkBounds
    htrunc hdiag hrow hblockrow hblockcol

end BookProof.YangMillsCertificateSeam

end
