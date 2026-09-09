import Mathlib
import BookProof.ChapterSirkSpectralGeometry
import BookProof.ChapterYangMillsHermite
import BookProof.ChapterNavierStokesHashimoto
import BookProof.ChapterNavierStokesDiffHashimoto
import BookProof.ChapterNavierStokesLagrangianKatoRellich
import BookProof.ChapterStarobinskyPotential

/-!
# Chapter SirkPerSystem — the Crouzeix geometry of each physical Hamiltonian

`CONSOLIDATED_PLAN.md` §12.2 **Gap 2** asks for the SIRK constants
"from the actual spectral geometry" of each of the four systems.
`ChapterSirkSpectralGeometry` reduced that request to a single object: the
**convex set `Σ` containing the numerical range of the shift-invert** the
algorithm iterates, which is inherited by every Krylov compression and hence
fixes `C` and `Dmin` uniformly in the reduction order `m`.  This chapter
instantiates `Σ` for every system whose selection theorem the project already
proves.

* **QYM** (`ym_sirk_crouzeix_domain`) — Friedrichs route, real shift `γ > 0`:
  the segment `[0, γ⁻¹]`.
* **NS Eulerian, sequence space** (`ns_sirk_crouzeix_domain`) — complex shift:
  the disc of radius `|Im γ|⁻¹`.
* **NS Eulerian, differential** (`nsDiff_sirk_crouzeix_domain`) — the same disc.
* **NS Lagrangian** (`lagrangian_sirk_crouzeix_domain`, and the concrete
  `diagKR_sirk_crouzeix_domain`) — the same disc.
* **QG `R + αR²`** (`qgR2_sirk_crouzeix_domain`) — the same disc.

For QG the shift-invert itself was not previously available: the project had the
essential self-adjointness and the Stone flow, but no resolvent object.
`qgR2_shiftInvert_selects` supplies it, from the ESA-selected extension and
`ChapterHashimotoComplexShifts.exists_isShiftInvertC`.

Each theorem states the domain inclusion **both** for the generator and for the
convex hull of the numerical range of an arbitrary order-`m` isometric Krylov
reduction `V : ℂᵐ → H`, which is the form `ChapterSirkEndToEnd`'s bound consumes.

## Honest boundary

The two Crouzeix inputs remain named hypotheses (see `ChapterH4`); what is fixed
here is the *domain* on which their sup-norm `Dmin` is measured, and it is fixed
by the shift alone — not by the reduction order, not by the seed.  The positive
route (QYM) gives the sharpest possible domain, a segment of the real axis; the
indefinite routes give a disc whose radius is the reciprocal distance of the
shift from the real axis, which is exactly the sensitivity the numerics report.
Nothing here claims a mass gap, global existence, or anything about
floating-point arithmetic (§12.2 Gap 6).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

namespace BookProof.ChapterSirkPerSystem

open BookProof.ChapterH4 BookProof.ChapterH9 BookProof.ChapterSirkSpectralGeometry
open BookProof.HashimotoShiftInvert BookProof.FarisLavine BookProof.EsaClosure
open BookProof.YangMillsFriedrichs BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.Starobinsky
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.NSHashimoto
open BookProof.NavierStokesFlow.DiffHashimoto BookProof.NavierStokesFlow.DifferentialL2
open BookProof.NavierStokesFlow.LagrangianEsa BookProof.NavierStokesFlow.LagrangianKatoRellich

/-! ## 1. Quantum Yang–Mills: the Friedrichs route, a real segment -/

/-- **The Crouzeix domain of the QYM shift-invert (§12.2 Gap 2, QYM).**  The
Hashimoto/Galerkin algorithm applied to the Yang–Mills Hamiltonian
`½Σπ² + ½ΣB²` at a positive real shift iterates the shift-invert of the
*Friedrichs* extension, whose numerical range is the real segment `[0, γ⁻¹]` —
and so is that of every order-`m` Krylov compression.  So the SIRK constants may
be measured on a segment determined by the shift alone. -/
theorem ym_sirk_crouzeix_domain (e : ℕ ≃ (Fin 99 →₀ ℕ))
    (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) {γ : ℝ} (hγ : 0 < γ) :
    ∃ (Dom : Submodule ℂ (L2d 99)) (A : Dom →ₗ[ℂ] L2d 99) (R : L2d 99 →L[ℂ] L2d 99),
      IsPositiveSelfAdjointExtension (ymHamiltonian (coreRepBasis e) fabc) A ∧
        IsShiftInvert A γ R ∧ IsSelfAdjoint R ∧
        numRange R ⊆ realSegment 0 γ⁻¹ ∧
        ∀ (m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] L2d 99),
          (∀ x, ‖V x‖ = ‖x‖) →
            convexHull ℝ (numRange (compress V R)) ⊆ realSegment 0 γ⁻¹ := by
  obtain ⟨Dom, A, R, hpsa, hR, hsa, _, _⟩ := ym_hermite_hashimoto_selects e fabc hγ
  have hsym := hpsa.2.1
  have hpos := hpsa.2.2.1
  refine ⟨Dom, A, R, hpsa, hR, hsa,
    numRange_subset_realSegment_of_shiftInvert hR hsym hpos hγ, ?_⟩
  intro m V hViso
  exact crouzeix_domain_shiftInvert hR hsym hpos hγ V hViso

/-! ## 2. Navier–Stokes, Eulerian: the complex-shift route, a disc -/

/-- **The Crouzeix domain of the NS Eulerian (sequence-space) shift-invert**
(§12.2 Gap 2, NS Eulerian).  The Eulerian generator is indefinite — strain,
vorticity and hoppings of arbitrary sign — so the algorithm runs at non-real
shifts; the numerical range of each resolvent, and of every Krylov compression
of it, lies in the disc of radius `|Im γ|⁻¹`. -/
theorem ns_sirk_crouzeix_domain (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)
    (b : HilbertBasis ℕ ℂ (L2I Vel)) (γ : ℕ → ℂ) (hγ : ∀ j, (γ j).im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2I Vel)) (G : Dom →ₗ[ℂ] L2I Vel)
      (X : ℕ → L2I Vel →L[ℂ] L2I Vel),
      IsSelfAdjointExtension (velCore A c) G ∧
      (∀ j, IsShiftInvertC G (γ j) (X j)) ∧
      (∀ j, numRange (X j) ⊆ Metric.closedBall (0 : ℂ) |(γ j).im|⁻¹) ∧
      ∀ (j m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] L2I Vel), (∀ x, ‖V x‖ = ‖x‖) →
        convexHull ℝ (numRange (compress V (X j)))
          ⊆ Metric.closedBall (0 : ℂ) |(γ j).im|⁻¹ := by
  obtain ⟨Dom, G, X, hext, hX, -, -, -, -, -, -, -, -⟩ := ns_hashimoto_selects A c b γ hγ
  have hsym := hext.2.1
  exact ⟨Dom, G, X, hext, hX,
    fun j => numRange_subset_closedBall_of_shiftInvertC (hX j) hsym (hγ j),
    fun j _ V hViso => crouzeix_domain_shiftInvertC (hX j) hsym (hγ j) V hViso⟩

/-- **The Crouzeix domain of the NS Eulerian differential shift-invert**
(§12.2 Gap 2, NS Eulerian differential): the same disc, on the Hermite core of
`L²(ℝ³)`. -/
theorem nsDiff_sirk_crouzeix_domain (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)
    {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2d 3)) (G : Dom →ₗ[ℂ] L2d 3) (X : L2d 3 →L[ℂ] L2d 3),
      IsSelfAdjointExtension ((polyGaussCore (d := 3)).subtype.comp (nsDiffH A c)) G ∧
      IsShiftInvertC G γ X ∧ ‖X‖ ≤ |γ.im|⁻¹ ∧
      numRange X ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ ∧
      ∀ (m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] L2d 3), (∀ x, ‖V x‖ = ‖x‖) →
        convexHull ℝ (numRange (compress V X)) ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ := by
  obtain ⟨Dom, G, X, hext, hX, hnorm, -, -⟩ := nsDiffH_shiftInvert_selects A c hγ
  have hsym := hext.2.1
  exact ⟨Dom, G, X, hext, hX, hnorm,
    numRange_subset_closedBall_of_shiftInvertC hX hsym hγ,
    fun _ V hViso => crouzeix_domain_shiftInvertC hX hsym hγ V hViso⟩

/-! ## 3. Navier–Stokes, Lagrangian: the complex-shift route -/

/-- **The Crouzeix domain of the NS Lagrangian shift-invert (§12.2 Gap 2, NS
Lagrangian).**  Abstract form: for any Lagrangian data whose full Hamiltonian is
essentially self-adjoint on the Lagrangian core, the selected extension has a
resolvent at every non-real shift whose Crouzeix domain — for the generator and
for every Krylov compression — is the disc of radius `|Im γ|⁻¹`. -/
theorem lagrangian_sirk_crouzeix_domain {F : Type*} [NormedAddCommGroup F]
    [InnerProductSpace ℂ F] [CompleteSpace F] (L : LagrangianFullData F)
    (hesa : EssentiallySelfAdjointOn L.D (lagrangianCore L)) {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F) (X : F →L[ℂ] F),
      IsSelfAdjointExtension (lagrangianCore L) A ∧ IsShiftInvertC A γ X ∧
      ‖X‖ ≤ |γ.im|⁻¹ ∧
      numRange X ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ ∧
      ∀ (m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] F), (∀ x, ‖V x‖ = ‖x‖) →
        convexHull ℝ (numRange (compress V X)) ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ := by
  obtain ⟨Dom, A, X, hext, hX, hnorm, -, -⟩ := lagrangian_shiftInvert_selects L hesa hγ
  have hsym := hext.2.1
  exact ⟨Dom, A, X, hext, hX, hnorm,
    numRange_subset_closedBall_of_shiftInvertC hX hsym hγ,
    fun _ V hViso => crouzeix_domain_shiftInvertC hX hsym hγ V hViso⟩

/-- **The concrete Kato–Rellich instance**: the same disc for the diagonal
Lagrangian model `diagKR`, at every shift of the multi-shift set. -/
theorem diagKR_sirk_crouzeix_domain (γ : ℕ → ℂ) (hγ : ∀ j, (γ j).im ≠ 0) :
    ∃ (Dom : Submodule ℂ L2N) (A : Dom →ₗ[ℂ] L2N) (X : ℕ → L2N →L[ℂ] L2N),
      IsSelfAdjointExtension (lagrangianCore diagKR) A ∧
      (∀ j, IsShiftInvertC A (γ j) (X j)) ∧
      (∀ j, numRange (X j) ⊆ Metric.closedBall (0 : ℂ) |(γ j).im|⁻¹) ∧
      ∀ (j m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] L2N), (∀ x, ‖V x‖ = ‖x‖) →
        convexHull ℝ (numRange (compress V (X j)))
          ⊆ Metric.closedBall (0 : ℂ) |(γ j).im|⁻¹ := by
  obtain ⟨Dom, A, X, hext, hX, -, -, -, -, -, -, -, -⟩ := diagKR_hashimoto_selects γ hγ
  have hsym := hext.2.1
  exact ⟨Dom, A, X, hext, hX,
    fun j => numRange_subset_closedBall_of_shiftInvertC (hX j) hsym (hγ j),
    fun j _ V hViso => crouzeix_domain_shiftInvertC (hX j) hsym (hγ j) V hViso⟩

/-! ## 4. Quantum gravity: the shift-invert of the `R + αR²` mode Hamiltonian -/

/-- **The QG shift-invert exists (new, §12.2 Gap 2, QG).**  The project had the
essential self-adjointness of the gauge-fixed `R + αR²` mode Hamiltonian and its
Stone flow, but no resolvent: the two-signed fiber symbol `(1/16)a² − (1/24)b²`
rules out the positivity that the real-shift route needs.  At a non-real shift no
positivity is required, and the ESA-selected extension has a bounded resolvent
with `‖X‖ ≤ |Im γ|⁻¹`. -/
theorem qgR2_shiftInvert_selects (a b : ℕ → ℝ) (M alpha : ℝ) (Rc : ℕ → ℝ)
    {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ L2Nat) (A : Dom →ₗ[ℂ] L2Nat) (X : L2Nat →L[ℂ] L2Nat),
      IsSelfAdjointExtension (qgR2ModeHamiltonian a b M alpha Rc) A ∧
      IsShiftInvertC A γ X ∧ ‖X‖ ≤ |γ.im|⁻¹ := by
  obtain ⟨T, -, hext, -⟩ := qgR2_stone_flow a b M alpha Rc
  obtain ⟨hcore, hsym, hcrit⟩ := hext
  obtain ⟨X, hX⟩ :=
    exists_isShiftInvertC hsym hγ (cshiftMap_surjective hsym hcrit hγ)
  exact ⟨T.domain, T.op, X, ⟨hcore, hsym, hcrit⟩, hX, hX.opNorm_le hsym hγ⟩

/-- **The Crouzeix domain of the QG shift-invert (§12.2 Gap 2, QG).**  The disc of
radius `|Im γ|⁻¹`, for the generator and for every order-`m` Krylov compression.
This is the formal counterpart of the numerics' observation that the two-signed
(hyperbolic) case is the one sensitive to how far the shift is taken from the
real axis. -/
theorem qgR2_sirk_crouzeix_domain (a b : ℕ → ℝ) (M alpha : ℝ) (Rc : ℕ → ℝ)
    {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ L2Nat) (A : Dom →ₗ[ℂ] L2Nat) (X : L2Nat →L[ℂ] L2Nat),
      IsSelfAdjointExtension (qgR2ModeHamiltonian a b M alpha Rc) A ∧
      IsShiftInvertC A γ X ∧ ‖X‖ ≤ |γ.im|⁻¹ ∧
      numRange X ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ ∧
      ∀ (m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] L2Nat), (∀ x, ‖V x‖ = ‖x‖) →
        convexHull ℝ (numRange (compress V X)) ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ := by
  obtain ⟨Dom, A, X, hext, hX, hnorm⟩ := qgR2_shiftInvert_selects a b M alpha Rc hγ
  have hsym := hext.2.1
  exact ⟨Dom, A, X, hext, hX, hnorm,
    numRange_subset_closedBall_of_shiftInvertC hX hsym hγ,
    fun _ V hViso => crouzeix_domain_shiftInvertC hX hsym hγ V hViso⟩

end BookProof.ChapterSirkPerSystem
