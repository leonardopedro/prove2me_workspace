import Mathlib
import BookProof.ChapterSirkCertifiedGap

/-!
# Chapter SirkGapTable — the per-coupling certified gap table and Richardson extrapolation
(T11, T12)

`CONSOLIDATED_PLAN.md` §13.7 (T11 and T12).  T6 (`ChapterSirkCertifiedGap`) turns one
emitted certificate into a lower bound for the parity gap of the truncated Hamiltonian.
Two things are still wanted around it:

* **T11** — a *table*: one certified row per coupling constant `g`, each row a T6
  instantiation, together with the comparison against the analytic strong-coupling
  value `g²/2`;
* **T12** — the finite-size → thermodynamic-limit **Richardson extrapolation**, stated
  as the conditional theorem the plan asks for ("if the finite-size correction is
  `O(l^{-p})` for a known `p`, then the extrapolated gap is …").

## Honest boundary

* Every certified statement is about the **truncated** operator `H_m(g)` at the given
  coupling; the continuum passage is the standing boundary of §13 and is not used.
* The rows of the table are *conditional*: a row proves what it proves given the two
  (or, for the two-sided version, four) enclosures the certificate for that coupling
  asserts.  The repository records the aggregates of exactly one solve — the `g = 2`,
  `m = 4` run — so exactly one row is instantiated with data; the rest of the table is
  the general statement, ready to be instantiated when further certificates are emitted.
* The Richardson section proves an *algebraic identity and its error propagation*.  The
  numerical values it is evaluated on are transcribed data, and the extrapolated number
  is a numerical estimate, not a certified bound: nothing here claims the
  thermodynamic-limit gap.

## Deliverables

* `gap_le_of_certificate` — the upper half of T6, so a certificate with two-sided
  enclosures gives a genuine *enclosure* `certified_gap_mem_interval` of the sector gap.
* `CouplingCertificate`, `CouplingCertificate.lo/hi`, **T11** `certified_gap_table`
  (every row of a table of certificates bounds the gap of its own operator from below)
  and `certified_gap_table_interval` (the two-sided form).
* `strongCoupling`, `strongCoupling_lt` and `strongCoupling_mem_of_certificate` — the
  analytic `g²/2` prediction, its strict monotonicity in the coupling, and the
  per-row consistency check; `qcdG2M4_row`, `qcdG2M4_row_lo`,
  `qcdG2M4_strongCoupling_consistent` — the one recorded row, whose certified window
  `[1.932, 2.043]` does contain the analytic value `g²/2 = 2` at `g = 2`.
* **T12** `richardson`, `richardson_exact` (the extrapolation is exact for a pure
  `C·l^{-p}` correction), `richardson_error` (its error propagation), and
  `richardson_qym_g4` — the evaluation on the recorded finite-size data.

Everything is `sorry`-free and `axiom`-free.
-/

noncomputable section

namespace BookProof.SirkGapTable

open BookProof.SirkCertifiedGap

/-! ## 1. The upper half: a certificate encloses the gap -/

section Operator

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- **The upper half of T6.**  The two reverse enclosures — the even-sector Ritz value
is not below the even ground energy by more than its width, and the odd sector ground
energy is not above its Ritz value by more than its width — bound the sector gap from
above by `θᵒ − θᵉ + (δᵒ + δᵉ)`. -/
theorem gap_le_of_certificate {T P : E →ₗ[ℂ] E} {thetaE thetaO deltaE deltaO : ℝ}
    (hEven : thetaE - deltaE ≤ sectorGround T P 1)
    (hOdd : sectorGround T P (-1) ≤ thetaO + deltaO) :
    sectorGround T P (-1) - sectorGround T P 1 ≤ thetaO - thetaE + (deltaO + deltaE) := by
  linarith

/-- **The certified enclosure.**  With all four enclosures the sector gap of the
truncated Hamiltonian lies in the certified window `[θᵒ − θᵉ − (δᵒ + δᵉ),
θᵒ − θᵉ + (δᵒ + δᵉ)]`. -/
theorem certified_gap_mem_interval {T P : E →ₗ[ℂ] E} {thetaE thetaO deltaE deltaO : ℝ}
    (hEvenHi : sectorGround T P 1 ≤ thetaE + deltaE)
    (hEvenLo : thetaE - deltaE ≤ sectorGround T P 1)
    (hOddLo : thetaO - deltaO ≤ sectorGround T P (-1))
    (hOddHi : sectorGround T P (-1) ≤ thetaO + deltaO) :
    sectorGround T P (-1) - sectorGround T P 1 ∈
      Set.Icc (thetaO - thetaE - (deltaO + deltaE)) (thetaO - thetaE + (deltaO + deltaE)) :=
  ⟨certified_parity_gap hEvenHi hOddLo, gap_le_of_certificate hEvenLo hOddHi⟩

end Operator

/-! ## 2. T11 — the per-coupling table -/

/-- One row of the certified gap table: a coupling constant with the measured sector
Ritz difference and the assembled width of its solve. -/
structure CouplingCertificate where
  /-- The coupling constant `g` of the row. -/
  g : ℝ
  /-- The measured sector Ritz difference `θᵒ − θᵉ`. -/
  gap : ℝ
  /-- The assembled certified width `δᵒ + δᵉ`. -/
  width : ℝ
  /-- Widths are nonnegative. -/
  width_nonneg : 0 ≤ width

/-- The lower end of a row's certified window. -/
def CouplingCertificate.lo (c : CouplingCertificate) : ℝ := c.gap - c.width

/-- The upper end of a row's certified window. -/
def CouplingCertificate.hi (c : CouplingCertificate) : ℝ := c.gap + c.width

/-- A row's window is nonempty. -/
theorem CouplingCertificate.lo_le_hi (c : CouplingCertificate) : c.lo ≤ c.hi := by
  have := c.width_nonneg
  simp only [CouplingCertificate.lo, CouplingCertificate.hi]
  linarith

section Table

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- **T11 — the certified gap table.**  Given, for each of finitely many couplings, a
truncated Hamiltonian with its sector involution `P` (on the gauge-fixed QYM
Hamiltonian of record: the reflection `R`), a certificate row and the two enclosures
that row asserts, *every* row certifies a lower bound for the sector gap of its own
operator. -/
theorem certified_gap_table {n : ℕ} (row : Fin n → CouplingCertificate)
    (T P : Fin n → E →ₗ[ℂ] E) (thetaE thetaO deltaE deltaO : Fin n → ℝ)
    (hgap : ∀ i, (row i).gap = thetaO i - thetaE i)
    (hwidth : ∀ i, (row i).width = deltaO i + deltaE i)
    (hEven : ∀ i, sectorGround (T i) (P i) 1 ≤ thetaE i + deltaE i)
    (hOdd : ∀ i, thetaO i - deltaO i ≤ sectorGround (T i) (P i) (-1)) :
    ∀ i, (row i).lo ≤ sectorGround (T i) (P i) (-1) - sectorGround (T i) (P i) 1 := by
  intro i
  have h := certified_parity_gap (T := T i) (P := P i) (hEven i) (hOdd i)
  simp only [CouplingCertificate.lo, hgap i, hwidth i]
  linarith

/-- **T11, the two-sided form.**  With the reverse enclosures as well, every row
*encloses* the parity gap of its own operator. -/
theorem certified_gap_table_interval {n : ℕ} (row : Fin n → CouplingCertificate)
    (T P : Fin n → E →ₗ[ℂ] E) (thetaE thetaO deltaE deltaO : Fin n → ℝ)
    (hgap : ∀ i, (row i).gap = thetaO i - thetaE i)
    (hwidth : ∀ i, (row i).width = deltaO i + deltaE i)
    (hEvenHi : ∀ i, sectorGround (T i) (P i) 1 ≤ thetaE i + deltaE i)
    (hEvenLo : ∀ i, thetaE i - deltaE i ≤ sectorGround (T i) (P i) 1)
    (hOddLo : ∀ i, thetaO i - deltaO i ≤ sectorGround (T i) (P i) (-1))
    (hOddHi : ∀ i, sectorGround (T i) (P i) (-1) ≤ thetaO i + deltaO i) :
    ∀ i, sectorGround (T i) (P i) (-1) - sectorGround (T i) (P i) 1
        ∈ Set.Icc (row i).lo (row i).hi := by
  intro i
  have h := certified_gap_mem_interval (T := T i) (P := P i)
    (hEvenHi i) (hEvenLo i) (hOddLo i) (hOddHi i)
  simp only [CouplingCertificate.lo, CouplingCertificate.hi, hgap i, hwidth i]
  exact h

end Table

/-! ## 3. The analytic strong-coupling value and the per-row check -/

/-- The analytic strong-coupling prediction for the parity gap: `g²/2`.  (The excluded
`O(g⁴)` magnetic correction is kept outside, exactly as in
`certified_parity_gap_strong_coupling`.) -/
def strongCoupling (g : ℝ) : ℝ := g ^ 2 / 2

/-- The strong-coupling prediction is strictly increasing in the coupling. -/
theorem strongCoupling_lt {g₁ g₂ : ℝ} (h0 : 0 ≤ g₁) (h : g₁ < g₂) :
    strongCoupling g₁ < strongCoupling g₂ := by
  have : g₁ ^ 2 < g₂ ^ 2 := by nlinarith
  simpa [strongCoupling] using by linarith

/-- A row is *consistent with the strong-coupling prediction* when the analytic value
`g²/2` lies inside its certified window. -/
def CouplingCertificate.strongCouplingConsistent (c : CouplingCertificate) : Prop :=
  strongCoupling c.g ∈ Set.Icc c.lo c.hi

/-- If a row is consistent with the strong-coupling prediction and its enclosures hold,
the analytic value is not below the certified lower bound of the *gap itself*. -/
theorem strongCoupling_mem_of_certificate {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℂ E] {T P : E →ₗ[ℂ] E} (c : CouplingCertificate)
    {thetaE thetaO deltaE deltaO : ℝ}
    (hgap : c.gap = thetaO - thetaE) (hwidth : c.width = deltaO + deltaE)
    (hEven : sectorGround T P 1 ≤ thetaE + deltaE)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1))
    (hcons : c.strongCouplingConsistent) :
    c.lo ≤ sectorGround T P (-1) - sectorGround T P 1 ∧ c.lo ≤ strongCoupling c.g := by
  have h := certified_parity_gap (T := T) (P := P) hEven hOdd
  have hlo : c.lo ≤ sectorGround T P (-1) - sectorGround T P 1 := by
    simp only [CouplingCertificate.lo, hgap, hwidth]
    linarith
  exact ⟨hlo, hcons.1⟩

/-- The one row the repository records: the `g = 2`, `m = 4` run of the lattice-era
cross-benchmark (historical fixture; the mass-gap object of record is the gauge-fixed
QYM Hamiltonian `qcd_ym_hamiltonian(g)`, whose reflection-sector certificates fill the
same row type), measured sector gap `1.9875`, assembled width `0.0555` (the same two
transcribed numbers
as `SirkCertifiedGap.qcdG2M4`). -/
def qcdG2M4Row : CouplingCertificate where
  g := 2
  gap := 1.9875
  width := 0.0555
  width_nonneg := by norm_num

/-- Its certified window is `[1.932, 2.043]`. -/
theorem qcdG2M4Row_lo : qcdG2M4Row.lo = 1.932 ∧ qcdG2M4Row.hi = 2.043 := by
  constructor <;> norm_num [CouplingCertificate.lo, CouplingCertificate.hi, qcdG2M4Row]

/-- **The recorded row is consistent with the analytic strong-coupling value**: at
`g = 2` the prediction `g²/2 = 2` lies inside the certified window `[1.932, 2.043]`. -/
theorem qcdG2M4_strongCoupling_consistent : qcdG2M4Row.strongCouplingConsistent := by
  constructor <;>
    norm_num [CouplingCertificate.lo, CouplingCertificate.hi, qcdG2M4Row, strongCoupling]

/-! ## 4. T12 — Richardson extrapolation of the finite-size gaps

The plan writes the extrapolation as `Δ(∞) ≈ Δ(l₂) + (Δ(l₂) − Δ(l₁))/((l₁/l₂)^p − 1)`.
With `l₁ < l₂` that ratio is the wrong way round — the correction then *adds* the tail
instead of cancelling it — so the definition below uses `(l₂/l₁)^p − 1`, which is what
makes the extrapolation exact (`richardson_exact`). -/

open Real

/-- The Richardson extrapolant of two finite-size values `d₁ = Δ(l₁)`, `d₂ = Δ(l₂)` for a
leading correction exponent `p`. -/
def richardson (d1 d2 l1 l2 p : ℝ) : ℝ := d2 + (d2 - d1) / ((l2 / l1) ^ p - 1)

/-- The extrapolation ratio is `> 1`, so the extrapolant is well defined. -/
theorem one_lt_ratio {l1 l2 p : ℝ} (hl1 : 0 < l1) (hl : l1 < l2) (hp : 0 < p) :
    1 < (l2 / l1) ^ p := by
  have h1 : 1 < l2 / l1 := (one_lt_div hl1).2 hl
  exact (one_lt_rpow_iff (by linarith)).2 (Or.inl ⟨h1, hp⟩)

/-- **T12 — exactness.**  If the finite-size gaps follow the pure power law
`Δ(l) = Δ(∞) + C·l^{-p}`, the Richardson extrapolant of any two of them is exactly the
thermodynamic-limit value `Δ(∞)`. -/
theorem richardson_exact {D C l1 l2 p : ℝ} (hl1 : 0 < l1) (hl : l1 < l2) (hp : 0 < p) :
    richardson (D + C * l1 ^ (-p)) (D + C * l2 ^ (-p)) l1 l2 p = D := by
  have hl2 : 0 < l2 := lt_trans hl1 hl
  set A := l1 ^ p with hA
  set B := l2 ^ p with hB
  have hApos : 0 < A := rpow_pos_of_pos hl1 p
  have hBpos : 0 < B := rpow_pos_of_pos hl2 p
  have hAB : A < B := by
    simpa [hA, hB] using rpow_lt_rpow hl1.le hl hp
  have h1 : l1 ^ (-p) = A⁻¹ := by rw [hA, rpow_neg hl1.le]
  have h2 : l2 ^ (-p) = B⁻¹ := by rw [hB, rpow_neg hl2.le]
  have hratio : (l2 / l1) ^ p = B / A := by
    rw [div_rpow hl2.le hl1.le, hA, hB]
  rw [richardson, h1, h2, hratio]
  have hne : B - A ≠ 0 := by linarith
  field_simp
  ring

/-- **T12 — error propagation.**  If each finite-size value is known only up to `ε`
around the power law, the Richardson extrapolant is within `ε·(1 + 2/X)` of `Δ(∞)`,
where `X = (l₂/l₁)^p − 1` is the extrapolation denominator. -/
theorem richardson_error {D C l1 l2 p d1 d2 eps : ℝ}
    (hl1 : 0 < l1) (hl : l1 < l2) (hp : 0 < p)
    (h1 : |d1 - (D + C * l1 ^ (-p))| ≤ eps) (h2 : |d2 - (D + C * l2 ^ (-p))| ≤ eps) :
    |richardson d1 d2 l1 l2 p - D| ≤ eps * (1 + 2 / ((l2 / l1) ^ p - 1)) := by
  have hX : 1 < (l2 / l1) ^ p := one_lt_ratio hl1 hl hp
  set X := (l2 / l1) ^ p - 1 with hXdef
  have hXpos : 0 < X := by simp only [hXdef]; linarith
  have hexact : richardson (D + C * l1 ^ (-p)) (D + C * l2 ^ (-p)) l1 l2 p = D :=
    richardson_exact hl1 hl hp
  set e1 := d1 - (D + C * l1 ^ (-p)) with he1
  set e2 := d2 - (D + C * l2 ^ (-p)) with he2
  have hdiff : richardson d1 d2 l1 l2 p - D = e2 + (e2 - e1) / X := by
    have : richardson d1 d2 l1 l2 p
        - richardson (D + C * l1 ^ (-p)) (D + C * l2 ^ (-p)) l1 l2 p
        = e2 + (e2 - e1) / X := by
      simp only [richardson, he1, he2, hXdef]
      field_simp
      ring
    rw [← hexact]
    exact this
  rw [hdiff]
  have hb1 : |e1| ≤ eps := h1
  have hb2 : |e2| ≤ eps := h2
  have hsplit : |e2 + (e2 - e1) / X| ≤ |e2| + (|e2| + |e1|) / X := by
    calc |e2 + (e2 - e1) / X| ≤ |e2| + |(e2 - e1) / X| := abs_add_le _ _
      _ = |e2| + |e2 - e1| / X := by rw [abs_div, abs_of_pos hXpos]
      _ ≤ |e2| + (|e2| + |e1|) / X := by
          gcongr
          exact abs_sub _ _
  have hmono : |e2| + (|e2| + |e1|) / X ≤ eps + (eps + eps) / X := by gcongr
  have : eps + (eps + eps) / X = eps * (1 + 2 / X) := by field_simp; ring
  linarith [hsplit, hmono, this.le, this.ge]

/-! ### The recorded finite-size data

The three numbers below are transcribed numerical data (the `g = 4` finite-size study of
the lattice-era cross-benchmark at sizes `l = 2, 3, 4` — a solver-level record only,
*not* part of the gauge-fixed formalization chain).  The theorem is the *evaluation* of the
extrapolant on
them for `p = 2`; it is a numerical record, not a certified bound on the
thermodynamic-limit gap. -/

/-- The recorded finite-size gap at lattice size `l = 3`, coupling `g = 4`. -/
def qymG4L3 : ℝ := 7.999826

/-- The recorded finite-size gap at lattice size `l = 4`, coupling `g = 4`. -/
def qymG4L4 : ℝ := 7.999830

/-- The Richardson extrapolant of the recorded `g = 4` finite-size gaps at `l = 3, 4`
with the leading exponent `p = 2`. -/
theorem richardson_qym_g4 :
    richardson qymG4L3 qymG4L4 3 4 2 = 27999423 / 3500000 := by
  have hr : ((4 : ℝ) / 3) ^ (2 : ℝ) = 16 / 9 := by
    rw [show (2 : ℝ) = ((2 : ℕ) : ℝ) by norm_num, rpow_natCast]
    norm_num
  rw [richardson, hr, qymG4L3, qymG4L4]
  norm_num

/-- The extrapolated value lies above both recorded finite-size gaps: the finite-size
sequence increases towards it. -/
theorem richardson_qym_g4_gt : qymG4L4 < richardson qymG4L3 qymG4L4 3 4 2 := by
  rw [richardson_qym_g4, qymG4L4]
  norm_num

end BookProof.SirkGapTable
