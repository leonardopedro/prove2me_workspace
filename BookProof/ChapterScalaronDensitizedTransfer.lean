import Mathlib
import BookProof.ChapterStarobinskyPotential
import BookProof.ChapterQuantumGravityHalfDensity
import BookProof.ChapterNavierStokesFockContinuum
import BookProof.ChapterStoneBridge

/-!
# The conformal-mode potential after the densitized change of variables

`BookProof.ChapterStarobinskyPotential` proves the two `R + αR²` potential bounds in the
*physical* variables — `starobinskyV_nonneg` and the completed square
`confV_ge : −M⁴/(16α) ≤ V₃(R_c)` — and runs the essential-self-adjointness and Stone-flow
machinery in the mode (Hermite-basis) realisation.
`BookProof.ChapterQuantumGravityDensitized` performs the densitized change of variables
`y = √e` at the level of symbols, and `BookProof.ChapterQuantumGravityHalfDensity`
constructs the half-density unitary

  `W : L²((0,∞), de) ≃ₗᵢ[ℂ] L²((0,∞), 2y dy)`,  `(W g)(y) = g(y²)`

that makes the point map `e = y²` a Hilbert-space isomorphism.

This module is step 2 of plan item A5: it carries the potential bound *through* that change
of variables, in the continuum (not the mode) realisation, and shows that the resulting
Hamiltonians are unitarily equivalent, so that essential self-adjointness genuinely
*transfers* along `W` rather than being re-proved on each side.

## Contents

* `densConfV M α y = V₃(y²)` — the conformal-mode potential written in the densitized
  coordinate, with `densConfV_comp_densY` identifying it as the pullback of `V₃` along
  `y = √e`;
* `densConfV_ge`, `densConfV_bddBelow` — **the bound survives the change of variables**:
  `−M⁴/(16α) ≤ densConfV M α y` for every `y`, uniformly;
* `densConfV_zero_alpha_tendsto_atBot` — and it survives *because* of `αR²`: at `α = 0` the
  densitized potential still tends to `−∞`, so pure general relativity gains nothing from
  the change of variables;
* `physConfCore` / `physConfOp` and `densConfCore` / `densConfOp` — the multiplication
  operators by `V₃` on `L²((0,∞), de)` and by `densConfV` on `L²((0,∞), 2y dy)`, on their
  bounded-energy cores;
* `halfDensityUnitary_mem_densConfCore`, `halfDensityUnitary_densConfCore_surjective`,
  `halfDensityUnitary_intertwines` — the half-density unitary carries the physical core
  onto the densitized core and intertwines the two operators;
* `densConf_hasZeroDeficiencyOn` and `physConf_hasZeroDeficiencyOn_transfer` — vanishing
  adjoint deficiency of the densitized operator, and its **transfer** to the physical one
  through `BookProof.QuantumGravityHalfDensity.qg_halfDensity_transfer`;
* `densConfOp_quadForm_ge` — the bound at the level of the operator: the quadratic form of
  the densitized Hamiltonian satisfies `⟪f, H f⟫ ≥ −M⁴/(16α)·‖f‖²`, which is the sign every
  relative-bound / commutator-form combination needs;
* `physConf_stone_flow`, `densConf_stone_flow` — the resulting unitary groups.

## Honest boundary

This is the *potential* half of the continuum problem: the operators here are the
multiplication (potential) parts, in one conformal variable, and the change of variables is
the conformal one `e = y²` of `ChapterQuantumGravityDensitized` Part A.  The kinetic
absorption identities (`inv_eq_four_mul_deriv_densY_sq`, `kinetic_absorption`,
`conformal_absorption`) are proved there at the level of symbols; assembling them with the
present transfer into the full continuum `L²(ℝ⁸⁴)` operator still requires the Strichartz
finite-speed / direct-integral input recorded as the standing residue of A1 and A5, and the
gauge/BRST sector remains outside the statement.  No mass gap and no global existence is
claimed.
-/

namespace BookProof.ScalaronDensitized

open MeasureTheory Set Filter Topology
open BookProof.Starobinsky BookProof.QuantumGravityDensitized
open BookProof.QuantumGravityHalfDensity
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.FockContinuum
open BookProof.FarisLavine BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

/-- The physical measure `de` on the nondegenerate branch `(0, ∞)`. -/
abbrev physMeasure : Measure ℝ := volume.restrict (Set.Ioi (0 : ℝ))

/-! ## The potential in the densitized coordinate -/

/-- **The conformal-mode potential in the densitized coordinate.**  Under the change of
variables `e = y²` of `BookProof.QuantumGravityDensitized` the conformal-mode potential
`V₃(R_c) = −(M²/2)R_c + αR_c²` becomes `y ↦ V₃(y²)`. -/
def densConfV (M alpha y : ℝ) : ℝ := confV M alpha (y ^ 2)

theorem densConfV_apply (M alpha y : ℝ) : densConfV M alpha y = confV M alpha (y ^ 2) := rfl

/-- The densitized potential is the pullback of `V₃` along `y = √e`: evaluating it at the
densitized coordinate `densY e = √e` returns the physical potential. -/
theorem densConfV_comp_densY {M alpha e : ℝ} (he : 0 ≤ e) :
    densConfV M alpha (densY e) = confV M alpha e := by
  rw [densConfV_apply, densY_sq he]

/-- **The bound survives the densitized change of variables.**  The transformed
conformal-mode potential is still bounded below by `−M⁴/(16α)`, uniformly in the densitized
coordinate — the sign the essential-self-adjointness routes need. -/
theorem densConfV_ge {M alpha : ℝ} (halpha : 0 < alpha) (y : ℝ) :
    -(M ^ 4 / (16 * alpha)) ≤ densConfV M alpha y :=
  confV_ge halpha (y ^ 2)

theorem densConfV_bddBelow {M alpha : ℝ} (halpha : 0 < alpha) :
    BddBelow (Set.range fun y => densConfV M alpha y) :=
  ⟨-(M ^ 4 / (16 * alpha)), by rintro _ ⟨y, rfl⟩; exact densConfV_ge halpha y⟩

/-- **The change of variables buys nothing for pure general relativity.**  At `α = 0` the
densitized conformal potential is `−(M²/2)y²`, which still tends to `−∞`: it is the `αR²`
term, not the densitization, that produces the lower bound. -/
theorem densConfV_zero_alpha_tendsto_atBot {M : ℝ} (hM : M ≠ 0) :
    Tendsto (fun y => densConfV M 0 y) atTop atBot := by
  have hpos : 0 < M ^ 2 / 2 := by positivity
  have hsq : Tendsto (fun y : ℝ => y ^ 2) atTop atTop := tendsto_pow_atTop two_ne_zero
  have h : Tendsto (fun t : ℝ => -(M ^ 2 / 2) * t) atTop atBot :=
    Filter.Tendsto.const_mul_atTop_of_neg (by linarith : -(M ^ 2 / 2) < 0) tendsto_id
  refine (h.comp hsq).congr fun y => ?_
  simp [densConfV, confV, Function.comp]

/-! ## Measurability -/

theorem measurable_confV (M alpha : ℝ) : Measurable (confV M alpha) := by
  unfold confV; fun_prop

theorem measurable_densConfV (M alpha : ℝ) : Measurable (densConfV M alpha) := by
  unfold densConfV confV; fun_prop

/-! ## The two multiplication operators -/

variable (M alpha : ℝ)

/-- The bounded-energy core of the physical conformal Hamiltonian on `L²((0,∞), de)`. -/
def physConfCore : Submodule ℂ (Lp ℂ 2 physMeasure) :=
  boundedEnergyCore physMeasure (confV M alpha)

/-- **The physical conformal-mode Hamiltonian**: multiplication by `V₃(e)` on
`L²((0,∞), de)`. -/
def physConfOp : physConfCore M alpha →ₗ[ℂ] physConfCore M alpha :=
  multOp physMeasure (measurable_confV M alpha)

/-- The bounded-energy core of the densitized conformal Hamiltonian on
`L²((0,∞), 2y dy)`. -/
def densConfCore : Submodule ℂ (Lp ℂ 2 qgSrcMeasure) :=
  boundedEnergyCore qgSrcMeasure (densConfV M alpha)

/-- **The densitized conformal-mode Hamiltonian**: multiplication by `V₃(y²)` on
`L²((0,∞), 2y dy)`. -/
def densConfOp : densConfCore M alpha →ₗ[ℂ] densConfCore M alpha :=
  multOp qgSrcMeasure (measurable_densConfV M alpha)

theorem physConfCore_dense :
    Dense ((physConfCore M alpha : Submodule ℂ (Lp ℂ 2 physMeasure)) :
      Set (Lp ℂ 2 physMeasure)) :=
  boundedEnergyCore_dense physMeasure (measurable_confV M alpha)

theorem densConfCore_dense :
    Dense ((densConfCore M alpha : Submodule ℂ (Lp ℂ 2 qgSrcMeasure)) :
      Set (Lp ℂ 2 qgSrcMeasure)) :=
  boundedEnergyCore_dense qgSrcMeasure (measurable_densConfV M alpha)

theorem physConfOp_symmetricOn :
    SymmetricOn (physConfCore M alpha)
      ((physConfCore M alpha).subtype.comp (physConfOp M alpha)) :=
  multOp_isSymmetricDom physMeasure (measurable_confV M alpha)

theorem densConfOp_symmetricOn :
    SymmetricOn (densConfCore M alpha)
      ((densConfCore M alpha).subtype.comp (densConfOp M alpha)) :=
  multOp_isSymmetricDom qgSrcMeasure (measurable_densConfV M alpha)

/-! ## The half-density unitary carries one picture to the other -/

/-- The half-density unitary maps the physical core into the densitized core. -/
theorem halfDensityUnitary_mem_densConfCore (x : physConfCore M alpha) :
    halfDensityUnitary (x : Lp ℂ 2 physMeasure) ∈ densConfCore M alpha := by
  obtain ⟨n, hn⟩ := x.2
  refine ⟨n, ?_⟩
  have hpull := measurePreserving_qgSquare.quasiMeasurePreserving.ae hn
  filter_upwards [halfDensityUnitary_apply ((x : Lp ℂ 2 physMeasure)), hpull] with y hy hpx hbig
  rw [hy]
  simp only [qgSquare] at hpx
  exact hpx hbig

/-- Every densitized core state is the image of a physical core state. -/
theorem halfDensityUnitary_densConfCore_surjective (h : densConfCore M alpha) :
    ∃ x : physConfCore M alpha,
      halfDensityUnitary (x : Lp ℂ 2 physMeasure) = (h : Lp ℂ 2 qgSrcMeasure) := by
  obtain ⟨n, hn⟩ := h.2
  have hmem : (halfDensityUnitary.symm (h : Lp ℂ 2 qgSrcMeasure)) ∈ physConfCore M alpha := by
    refine ⟨n, ?_⟩
    have hpull := measurePreserving_qgSqrt.quasiMeasurePreserving.ae hn
    filter_upwards [halfDensityUnitary_symm_apply ((h : Lp ℂ 2 qgSrcMeasure)), hpull,
      ae_restrict_mem measurableSet_Ioi] with e he hpe hepos hbig
    rw [he]
    refine hpe ?_
    rwa [densConfV_apply, Real.sq_sqrt (le_of_lt hepos)]
  exact ⟨⟨_, hmem⟩, halfDensityUnitary.apply_symm_apply _⟩

/-- **The two Hamiltonians are intertwined by the half-density unitary.** -/
theorem halfDensityUnitary_intertwines (x : physConfCore M alpha) :
    ((densConfOp M alpha ⟨halfDensityUnitary (x : Lp ℂ 2 physMeasure),
        halfDensityUnitary_mem_densConfCore M alpha x⟩ : densConfCore M alpha) :
          Lp ℂ 2 qgSrcMeasure)
      = halfDensityUnitary ((physConfOp M alpha x : physConfCore M alpha) :
          Lp ℂ 2 physMeasure) := by
  refine Lp.ext ?_
  have h1 := multOp_coeFn qgSrcMeasure (measurable_densConfV M alpha)
    (⟨halfDensityUnitary (x : Lp ℂ 2 physMeasure),
      halfDensityUnitary_mem_densConfCore M alpha x⟩ : densConfCore M alpha)
  have h2 := halfDensityUnitary_apply ((x : Lp ℂ 2 physMeasure))
  have h3 := halfDensityUnitary_apply
    (((physConfOp M alpha x : physConfCore M alpha) : Lp ℂ 2 physMeasure))
  have h4 := (multOp_coeFn physMeasure (measurable_confV M alpha) x).comp_tendsto
    measurePreserving_qgSquare.quasiMeasurePreserving.tendsto_ae
  filter_upwards [h1, h2, h3, h4] with y hy1 hy2 hy3 hy4
  simp only [Function.comp_apply, qgSquare] at hy4
  refine hy1.trans ?_
  rw [hy2, densConfV_apply, hy3]
  exact hy4.symm

/-! ## Essential self-adjointness, and its transfer -/

/-- The densitized conformal Hamiltonian has vanishing adjoint deficiency. -/
theorem densConf_hasZeroDeficiencyOn :
    HasZeroDeficiencyOn (densConfCore M alpha) (densConfOp M alpha) :=
  multOp_hasZeroDeficiencyOn qgSrcMeasure (measurable_densConfV M alpha)

/-- **The transfer step of plan item A5.**  Essential self-adjointness of the *densitized*
conformal Hamiltonian passes to the *physical* one along the half-density unitary of
`BookProof.ChapterQuantumGravityHalfDensity` — the physical statement is obtained by
transfer, not by a separate argument. -/
theorem physConf_hasZeroDeficiencyOn_transfer :
    HasZeroDeficiencyOn (physConfCore M alpha) (physConfOp M alpha) :=
  qg_halfDensity_transfer (halfDensityUnitary_mem_densConfCore M alpha)
    (halfDensityUnitary_densConfCore_surjective M alpha)
    (halfDensityUnitary_intertwines M alpha) (densConf_hasZeroDeficiencyOn M alpha)

theorem physConf_esa :
    EssentiallySelfAdjointOn (physConfCore M alpha)
      ((physConfCore M alpha).subtype.comp (physConfOp M alpha)) :=
  (essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn _ _).2
    (physConf_hasZeroDeficiencyOn_transfer M alpha)

theorem densConf_esa :
    EssentiallySelfAdjointOn (densConfCore M alpha)
      ((densConfCore M alpha).subtype.comp (densConfOp M alpha)) :=
  (essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn _ _).2
    (densConf_hasZeroDeficiencyOn M alpha)

/-! ## The bound at the level of the operator -/

section QuadForm

variable {X : Type*} [MeasurableSpace X]

/-- The squared `L²` norm is the integral of the squared pointwise norm. -/
theorem integral_norm_sq_eq_norm_sq (mu : Measure X) (f : Lp ℂ 2 mu) :
    ∫ a, ‖(f : X → ℂ) a‖ ^ 2 ∂mu = ‖f‖ ^ 2 := by
  have key : ∀ z : ℂ, (inner ℂ z z : ℂ) = ((‖z‖ ^ 2 : ℝ) : ℂ) := by
    intro z
    rw [inner_self_eq_norm_sq_to_K]
    norm_cast
  have h1 : (inner ℂ f f : ℂ) = ∫ a, (inner ℂ ((f : X → ℂ) a) ((f : X → ℂ) a) : ℂ) ∂mu :=
    L2.inner_def f f
  have h2 : (inner ℂ f f : ℂ) = ((‖f‖ ^ 2 : ℝ) : ℂ) := by
    rw [inner_self_eq_norm_sq_to_K]; norm_cast
  have h3 : ∫ a, (inner ℂ ((f : X → ℂ) a) ((f : X → ℂ) a) : ℂ) ∂mu
      = ((∫ a, ‖(f : X → ℂ) a‖ ^ 2 ∂mu : ℝ) : ℂ) := by
    rw [← integral_complex_ofReal]
    exact integral_congr_ae (Filter.Eventually.of_forall fun a => key _)
  rw [h3] at h1
  rw [h1] at h2
  exact_mod_cast h2

/-- **The quadratic form of a multiplication operator** is the integral of the multiplier
against the density `|f|²`. -/
theorem multOp_quadForm_eq (mu : Measure X) {g : X → ℝ} (hg : Measurable g)
    (f : boundedEnergyCore mu g) :
    quadForm ((boundedEnergyCore mu g).subtype.comp (multOp mu hg)) f
      = ∫ a, g a * ‖((f : Lp ℂ 2 mu) : X → ℂ) a‖ ^ 2 ∂mu := by
  have hkey : ∀ (z : ℂ) (r : ℝ), (inner ℂ z ((r : ℂ) * z) : ℂ) = ((r * ‖z‖ ^ 2 : ℝ) : ℂ) := by
    intro z r
    rw [RCLike.inner_apply]
    have h : (starRingEnd ℂ) z * z = ((‖z‖ : ℂ)) ^ 2 := Complex.conj_mul' z
    push_cast
    rw [← h]; ring
  have hinner : (inner ℂ ((f : Lp ℂ 2 mu))
      (((multOp mu hg f : boundedEnergyCore mu g) : Lp ℂ 2 mu)) : ℂ)
      = ((∫ a, g a * ‖((f : Lp ℂ 2 mu) : X → ℂ) a‖ ^ 2 ∂mu : ℝ) : ℂ) := by
    rw [L2.inner_def, ← integral_complex_ofReal]
    refine integral_congr_ae ?_
    filter_upwards [multOp_coeFn mu hg f] with a ha
    rw [ha, hkey]
  simp only [quadForm, LinearMap.comp_apply, Submodule.subtype_apply, hinner,
    Complex.ofReal_re]

/-- **A multiplication operator inherits the lower bound of its multiplier.**  If
`−c ≤ g` pointwise then the quadratic form of multiplication by `g` satisfies
`⟪f, g·f⟫ ≥ −c‖f‖²`: a pointwise bound on the potential *is* semiboundedness of the
operator. -/
theorem multOp_quadForm_ge (mu : Measure X) {g : X → ℝ} (hg : Measurable g) {c : ℝ}
    (hc : ∀ a, -c ≤ g a) (f : boundedEnergyCore mu g) :
    -c * ‖(f : Lp ℂ 2 mu)‖ ^ 2
      ≤ quadForm ((boundedEnergyCore mu g).subtype.comp (multOp mu hg)) f := by
  obtain ⟨n, hn⟩ := f.2
  have hsq : Integrable (fun a => ‖((f : Lp ℂ 2 mu) : X → ℂ) a‖ ^ 2) mu := by
    have h := (Lp.memLp (f : Lp ℂ 2 mu)).integrable_norm_rpow (by norm_num) (by norm_num)
    simpa [Real.rpow_natCast] using h
  have hmeas : AEStronglyMeasurable
      (fun a => g a * ‖((f : Lp ℂ 2 mu) : X → ℂ) a‖ ^ 2) mu :=
    hg.aestronglyMeasurable.mul ((Lp.aestronglyMeasurable (f : Lp ℂ 2 mu)).norm.pow 2)
  have hgint : Integrable (fun a => g a * ‖((f : Lp ℂ 2 mu) : X → ℂ) a‖ ^ 2) mu := by
    refine Integrable.mono (hsq.const_mul (n : ℝ)) hmeas ?_
    filter_upwards [hn] with a ha
    by_cases hb : |g a| ≤ (n : ℝ)
    · have h1 : ‖g a * ‖((f : Lp ℂ 2 mu) : X → ℂ) a‖ ^ 2‖
          = |g a| * ‖((f : Lp ℂ 2 mu) : X → ℂ) a‖ ^ 2 := by
        rw [Real.norm_eq_abs, abs_mul,
          abs_of_nonneg (by positivity : (0:ℝ) ≤ ‖((f : Lp ℂ 2 mu) : X → ℂ) a‖ ^ 2)]
      rw [h1]
      refine le_trans (mul_le_mul_of_nonneg_right hb (by positivity)) ?_
      exact le_abs_self _
    · rw [ha hb]; simp
  have hmono : ∫ a, -c * ‖((f : Lp ℂ 2 mu) : X → ℂ) a‖ ^ 2 ∂mu
      ≤ ∫ a, g a * ‖((f : Lp ℂ 2 mu) : X → ℂ) a‖ ^ 2 ∂mu := by
    refine integral_mono (hsq.const_mul _) hgint fun a => ?_
    exact mul_le_mul_of_nonneg_right (hc a) (by positivity)
  rw [multOp_quadForm_eq]
  refine le_trans (le_of_eq ?_) hmono
  rw [integral_const_mul, integral_norm_sq_eq_norm_sq]

end QuadForm

/-- **The lower bound, as an operator statement.**  The quadratic form of the densitized
conformal Hamiltonian is bounded below by `−M⁴/(16α)` times the squared norm: the
densitized potential bound is not merely pointwise, it is the semiboundedness of the
operator. -/
theorem densConfOp_quadForm_ge (halpha : 0 < alpha) (f : densConfCore M alpha) :
    -(M ^ 4 / (16 * alpha)) * ‖(f : Lp ℂ 2 qgSrcMeasure)‖ ^ 2
      ≤ quadForm ((densConfCore M alpha).subtype.comp (densConfOp M alpha)) f :=
  multOp_quadForm_ge qgSrcMeasure (measurable_densConfV M alpha)
    (fun y => densConfV_ge halpha y) f

/-- The same lower bound in the physical variables. -/
theorem physConfOp_quadForm_ge (halpha : 0 < alpha) (f : physConfCore M alpha) :
    -(M ^ 4 / (16 * alpha)) * ‖(f : Lp ℂ 2 physMeasure)‖ ^ 2
      ≤ quadForm ((physConfCore M alpha).subtype.comp (physConfOp M alpha)) f :=
  multOp_quadForm_ge physMeasure (measurable_confV M alpha)
    (fun e => confV_ge halpha e) f

/-! ## The unitary flows -/

theorem densConf_stone_flow :
    ∃ (T : UnboundedSelfAdjoint (Lp ℂ 2 qgSrcMeasure))
      (U : ℝ → (Lp ℂ 2 qgSrcMeasure →L[ℂ] Lp ℂ 2 qgSrcMeasure)),
      IsSelfAdjointExtension
        ((densConfCore M alpha).subtype.comp (densConfOp M alpha)) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ (densConfCore_dense M alpha) (densConfOp_symmetricOn M alpha)
    (densConf_esa M alpha)

theorem physConf_stone_flow :
    ∃ (T : UnboundedSelfAdjoint (Lp ℂ 2 physMeasure))
      (U : ℝ → (Lp ℂ 2 physMeasure →L[ℂ] Lp ℂ 2 physMeasure)),
      IsSelfAdjointExtension
        ((physConfCore M alpha).subtype.comp (physConfOp M alpha)) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ (physConfCore_dense M alpha) (physConfOp_symmetricOn M alpha)
    (physConf_esa M alpha)

end

end BookProof.ScalaronDensitized
