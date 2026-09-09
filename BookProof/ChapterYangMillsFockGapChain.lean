import Mathlib
import BookProof.ChapterFockFieldPerturbation
import BookProof.ChapterBandEnclosure

/-!
# Chapter YangMillsFockGapChain — the abstract gap chain, instantiated for gauge-fixed QYM

`CONSOLIDATED_PLAN.md`, "Next specialist package — instantiate the abstract gap chain",
asks that the abstract modules of the 2026-08-28 wave **not** be re-proved but instead be
instantiated for the concrete gauge-fixed Yang–Mills one-particle Hamiltonian, and that
their hypotheses be discharged as far as they honestly can be.

The concrete one-particle datum already exists in the project:

* `BookProof.YangMillsHermite.ymHamiltonian (coreRepBasis e) fabc` — the gauge-fixed
  one-particle Hamiltonian `H₁ = ½Σπ² + ½ΣB²` on the Gauss–polynomial core of `L²(ℝ⁹⁹)`;
* `BookProof.FockSecondQuantization.ymOnePart e fabc` — the same operator as an
  endomorphism of the finite-mode core `finiteModeDomain (coreBasis e)`;
* `BookProof.FockSecondQuantization.ymFockCol e fabc = opCol (coreBasis e) (ymOnePart e fabc)`
  — its matrix in the product Hermite basis, whose second quantization
  `dΓ(ymFockCol e fabc) = Σ_{j,k} ⟪e_j, H₁ e_k⟫ a†_j a_k` is the final nested-Fock
  Hamiltonian in the project's uniform creation-left/annihilation-right convention.

This chapter connects that datum to the abstract chain.

## Deliverables

* `isPosCol_shiftCol_opCol_of_form_gap` — the general bridge from a one-particle *form* gap
  `⟪x, A x⟫ ≥ μ‖x‖²` on the finite-mode core to the matrix gap condition
  `IsPosCol (shiftCol (opCol b A) μ)` consumed by `ChapterFockNumberPreservingGap`;
* `ym_quadForm_eq` — the one-particle Yang–Mills form is the form of `ymOnePart`;
* **`ym_fock_vacuum_annihilated`** — unconditionally, `dΓ(H₁) Ω = 0`: the outer vacuum is an
  exact zero-energy eigenstate of the final Hamiltonian;
* **`ym_isPosCol_shiftCol`** — the concrete matrix gap condition, from the one-particle form
  gap;
* **`ym_fock_gap_of_one_particle_form_gap`** — the `dΓ` lift: `dΓ(H₁) Ω = 0` and
  `Re⟪u, dΓ(H₁) u⟫ ≥ μ‖u‖²` for every vacuum-orthogonal finite-particle state;
* **`ym_fock_mass_gap_of_one_particle_form_gap`** — the same with `μ > 0`, together with the
  positive self-adjoint (Friedrichs) extension of `dΓ(H₁)` supplied by
  `ChapterFockSecondQuantization.ym_fock_friedrichs_extension`;
* **`ym_fock_gap_of_field_perturbation`** — the gap of `dΓ(H₁) + Φ(f)` under the unbounded,
  number-changing linear field coupling of `ChapterFockFieldPerturbation`, with the explicit
  smallness condition `2‖f‖ < μ`;
* **`ym_fock_gap_of_nested_ritz_bands`** — the certified-band route: nested certified bands
  containing the Galerkin Ritz values of the concrete one-particle operator give the
  one-particle form gap through
  `BandEnclosure.friedrichs_form_gap_of_nested_ritz_bands`, hence the whole nested-Fock
  conclusion, without ever reading a displayed Ritz value as a lower bound.

## Honest boundary

Everything here is **conditional on the one-particle form gap** `⟪x, H₁ x⟫ ≥ μ‖x‖²` on the
Gauss–polynomial core.  That hypothesis is exactly the input the certificate chain aims to
supply and is *not* proved here: the SIRK/Hashimoto certificate remains a statement about a
finite truncation, and `1.932` remains a certified truncated number.  What *is* proved is
that once such a form gap is available for the concrete gauge-fixed one-particle operator,
the whole nested-Fock conclusion follows for the concrete final Hamiltonian, including
under a linear unbounded field perturbation.  The cubic and quartic Yang–Mills interaction
terms are not covered.  No mass gap of the physical Yang–Mills Hamiltonian is claimed.

Everything is `sorry`-free and introduces no axioms.
-/

noncomputable section

namespace BookProof.YangMillsFockGapChain

open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation
open BookProof.FarisLavine BookProof.HermiteGalerkin
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.BandEnclosure

/-! ## 1. From a one-particle form gap to the matrix gap condition -/

section General

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- **The bridge.**  A one-particle *form* gap `⟪x, A x⟫ ≥ μ‖x‖²` on the finite-mode core
is exactly the matrix gap condition `h − μ ≥ 0` consumed by
`ChapterFockNumberPreservingGap.fock_gap_of_number_preserving`.

This is the step that `fock_gap_of_one_particle_form_gap` performs internally; it is
isolated here because the field-perturbation theorems of `ChapterFockFieldPerturbation`
consume `IsPosCol (shiftCol · μ)` directly. -/
theorem isPosCol_shiftCol_opCol_of_form_gap (b : HilbertBasis ℕ ℂ F)
    (A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b) {mu : ℝ}
    (hgap : ∀ x : finiteModeDomain b,
      mu * ‖(x : F)‖ ^ 2 ≤ quadForm ((finiteModeDomain b).subtype.comp A) x) :
    IsPosCol (shiftCol (opCol b A) mu) := by
  have hpos : ∀ x : finiteModeDomain b,
      0 ≤ quadForm ((finiteModeDomain b).subtype.comp
        (A - ((mu : ℝ) : ℂ) • LinearMap.id)) x := by
    intro x
    have hval : quadForm ((finiteModeDomain b).subtype.comp
        (A - ((mu : ℝ) : ℂ) • LinearMap.id)) x
        = quadForm ((finiteModeDomain b).subtype.comp A) x - mu * ‖(x : F)‖ ^ 2 := by
      simp only [quadForm, LinearMap.coe_comp, Function.comp_apply, Submodule.subtype_apply,
        LinearMap.sub_apply, LinearMap.smul_apply, LinearMap.id_apply, Submodule.coe_sub,
        Submodule.coe_smul, inner_sub_right, inner_smul_right, Complex.sub_re,
        Complex.re_ofReal_mul, inner_self_eq_norm_sq_to_K]
      norm_cast
    rw [hval]
    linarith [hgap x]
  rw [shiftCol_opCol]
  exact isPosCol_opCol hpos

end General

/-! ## 2. The concrete gauge-fixed Yang–Mills one-particle operator -/

variable (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ)

/-- The quadratic form of the gauge-fixed one-particle Yang–Mills Hamiltonian is the form of
`ymOnePart`, the endomorphism of the finite-mode core whose matrix is `ymFockCol`. -/
theorem ym_quadForm_eq (x : finiteModeDomain (coreBasis e)) :
    quadForm (ymHamiltonian (coreRepBasis e) fabc) x
      = quadForm ((finiteModeDomain (coreBasis e)).subtype.comp (ymOnePart e fabc)) x := rfl

/-- **The outer vacuum is an exact zero-energy eigenstate of the final Yang–Mills
Hamiltonian.**  This is unconditional: it needs no gap and no positivity, only that the
final Hamiltonian is the outer creation-left/annihilation-right enclosure `dΓ` of the
one-particle operator. -/
theorem ym_fock_vacuum_annihilated : dGamma (ymFockCol e fabc) vac = 0 :=
  dGamma_vac _

/-- **The concrete matrix gap condition.**  A one-particle form gap for the gauge-fixed
Yang–Mills Hamiltonian on the Gauss–polynomial core gives `h − μ ≥ 0` for its matrix in the
product Hermite basis. -/
theorem ym_isPosCol_shiftCol {mu : ℝ}
    (hgap : ∀ x : finiteModeDomain (coreBasis e),
      mu * ‖(x : L2d 99)‖ ^ 2 ≤ quadForm (ymHamiltonian (coreRepBasis e) fabc) x) :
    IsPosCol (shiftCol (ymFockCol e fabc) mu) :=
  isPosCol_shiftCol_opCol_of_form_gap (coreBasis e) (ymOnePart e fabc) hgap

/-! ## 3. The `dΓ` lift for the concrete Hamiltonian -/

/-- **The one-particle edge lifts to the outer nested-Fock Yang–Mills Hamiltonian.**  Given
the one-particle form gap `⟪x, H₁ x⟫ ≥ μ‖x‖²` on the Gauss–polynomial core with `μ ≥ 0`, the
final Hamiltonian `dΓ(H₁)` annihilates the outer vacuum and has energy at least `μ‖u‖²` on
every vacuum-orthogonal finite-particle state. -/
theorem ym_fock_gap_of_one_particle_form_gap {mu : ℝ} (hmu : 0 ≤ mu)
    (hgap : ∀ x : finiteModeDomain (coreBasis e),
      mu * ‖(x : L2d 99)‖ ^ 2 ≤ quadForm (ymHamiltonian (coreRepBasis e) fabc) x) :
    dGamma (ymFockCol e fabc) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        mu * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma (ymFockCol e fabc) u)) : ℂ).re :=
  fock_gap_of_one_particle_form_gap (coreBasis e) (ymOnePart e fabc) hmu hgap

/-- **The conditional Yang–Mills nested-Fock mass gap.**  With a *strictly positive*
one-particle form gap `μ > 0` on the Gauss–polynomial core:

* `dΓ(H₁)` has a positive self-adjoint (Friedrichs) extension;
* the outer vacuum has energy exactly `0`;
* every vacuum-orthogonal finite-particle state has energy at least `μ‖u‖² > 0` when
  `u ≠ 0`.

The one-particle form gap is a hypothesis, not a conclusion; see the honest boundary in the
chapter header. -/
theorem ym_fock_mass_gap_of_one_particle_form_gap {mu : ℝ} (hmu : 0 < mu)
    (hgap : ∀ x : finiteModeDomain (coreBasis e),
      mu * ‖(x : L2d 99)‖ ^ 2 ≤ quadForm (ymHamiltonian (coreRepBasis e) fabc) x) :
    (∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
        IsPositiveSelfAdjointExtension (dGammaOp (ymFockCol e fabc)) A) ∧
      dGamma (ymFockCol e fabc) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 → u ≠ 0 →
        0 < (inner ℂ (toLp u) (toLp (dGamma (ymFockCol e fabc) u)) : ℂ).re := by
  obtain ⟨hvac, hgapFock⟩ := ym_fock_gap_of_one_particle_form_gap e fabc hmu.le hgap
  refine ⟨ym_fock_friedrichs_extension e fabc, hvac, fun u h0 hu => ?_⟩
  have hnorm : 0 < ‖toLp u‖ := by
    have : toLp u ≠ 0 := fun hc => hu (toLp_injective (by simpa using hc))
    exact norm_pos_iff.mpr this
  have hquad := hgapFock u h0
  have hpos : 0 < mu * ‖toLp u‖ ^ 2 := by positivity
  linarith

/-! ## 4. The concrete Hamiltonian under an unbounded field perturbation -/

/-- **The conditional Yang–Mills gap survives a linear unbounded field coupling.**  With the
one-particle form gap `μ > 0` on the Gauss–polynomial core and a coupling vector `f` with
`2‖f‖ < μ`, the perturbed final Hamiltonian `dΓ(H₁) + Φ(f)` still has energy at least
`(μ − 2‖f‖)‖u‖²` on every vacuum-orthogonal finite-particle state, and `μ − 2‖f‖ > 0`.

`Φ(f) = a†(f) + a(f)` is neither bounded (`fieldVec_unbounded`) nor number-preserving
(`fieldVec_vac`), so this is not a corollary of the bounded interaction theory. -/
theorem ym_fock_gap_of_field_perturbation {mu : ℝ} (hmu : 0 < mu)
    (hgap : ∀ x : finiteModeDomain (coreBasis e),
      mu * ‖(x : L2d 99)‖ ^ 2 ≤ quadForm (ymHamiltonian (coreRepBasis e) fabc) x)
    {f : ℕ →₀ ℂ} (hf : 2 * l2norm f < mu) {u : FockAlg} (h0 : u 0 = 0) :
    0 < mu - 2 * l2norm f ∧
      (mu - 2 * l2norm f) * ‖toLp u‖ ^ 2
        ≤ (inner ℂ (toLp u) (toLp (dGamma (ymFockCol e fabc) u)) : ℂ).re
          + (inner ℂ (toLp u) (toLp (fieldVec f u)) : ℂ).re :=
  fock_gap_of_field_perturbation_pos hmu (ym_isPosCol_shiftCol e fabc hgap) hf h0

/-! ## 5. The certified-band route, instantiated -/

/-- **The SIRK/Hashimoto certified bands, fed into the concrete Yang–Mills chain.**  Suppose
the certified bands nest (`ChapterH8.sirk_band_contained`, abstracted as `NestedBands`) and
the order-`m` Galerkin Ritz value of the *concrete* gauge-fixed one-particle Yang–Mills
Hamiltonian on the Gauss–polynomial core lies in the order-`m` band, and suppose one band has
lower end at least `μ ≥ 0`.  Then every band encloses the form bottom of the core, and the
final nested-Fock Hamiltonian `dΓ(H₁)` annihilates the outer vacuum and has energy at least
`μ‖u‖²` on every vacuum-orthogonal finite-particle state.

This is the composition the plan asks for: the Ritz/band data are consumed through
`BandEnclosure.friedrichs_form_gap_of_nested_ritz_bands`, never by reading a displayed Ritz
value as a lower bound.  The nesting and the membership of the Ritz values in the bands are
hypotheses about the emitted certificate data; they are not proved here. -/
theorem ym_fock_gap_of_nested_ritz_bands {mu : ℝ} (hmu : 0 ≤ mu)
    {lo hi : ℕ → ℝ} (hnest : NestedBands lo hi)
    (hritz : ∀ m, ritzInf (ymHamiltonian (coreRepBasis e) fabc)
      (galerkinSpan (coreBasis e) (m + 1)) ∈ Set.Icc (lo m) (hi m))
    {m₀ : ℕ} (hlo : mu ≤ lo m₀) :
    (∀ m, ritzInf (ymHamiltonian (coreRepBasis e) fabc)
        (finiteModeDomain (coreBasis e)) ∈ Set.Icc (lo m) (hi m)) ∧
      dGamma (ymFockCol e fabc) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        mu * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma (ymFockCol e fabc) u)) : ℂ).re := by
  obtain ⟨hband, hmuInf, -⟩ := friedrichs_form_gap_of_nested_ritz_bands (coreBasis e)
    (ymHamiltonian (coreRepBasis e) fabc)
    (ymHamiltonian_symmetricOn (coreRepBasis e) fabc)
    (ymHamiltonian_quadForm_nonneg (coreRepBasis e) fabc) hnest hritz hlo
  have hgap := quadForm_ge_of_le_ritzInf (ymHamiltonian (coreRepBasis e) fabc)
    (ymHamiltonian_quadForm_nonneg (coreRepBasis e) fabc) hmuInf
  obtain ⟨hvac, hfock⟩ := ym_fock_gap_of_one_particle_form_gap e fabc hmu hgap
  exact ⟨hband, hvac, hfock⟩

/-! ## 6. Axiom audit -/

section Audit

#print axioms isPosCol_shiftCol_opCol_of_form_gap
#print axioms ym_fock_vacuum_annihilated
#print axioms ym_isPosCol_shiftCol
#print axioms ym_fock_gap_of_one_particle_form_gap
#print axioms ym_fock_mass_gap_of_one_particle_form_gap
#print axioms ym_fock_gap_of_field_perturbation
#print axioms ym_fock_gap_of_nested_ritz_bands

end Audit

end BookProof.YangMillsFockGapChain

end
