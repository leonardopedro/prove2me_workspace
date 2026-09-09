import Mathlib
import BookProof.ChapterFarisLavine

/-!
# Essential self-adjointness of the wave operator on the Schwartz core

This module proves that the d'Alembertian

$$\Box = -\partial_t^2 + \Delta_x$$

on spacetime `ℝ^{1+n}`, together with a real constant potential, is **essentially
self-adjoint** on `L²(ℝ^{1+n})` when taken on the Schwartz core.  This is the
Strichartz-type statement for hyperbolic wave operators: the (formally symmetric)
operator has vanishing deficiency indices, so it possesses exactly one self-adjoint
extension.

The proof follows the Fourier-multiplier route, which for a *constant-coefficient*
operator replaces the light-cone cut-off/energy estimates of the variable-coefficient
theory:

* Under the Fourier transform (a unitary of `L²` by Plancherel, available in Mathlib as
  `MeasureTheory.Lp.fourierTransformₗᵢ`) the operator `∑ i, c i • ∂_{w i}² + κ` becomes
  multiplication by the **real** symbol
  `symbolFn c w κ ξ = ∑ i, c i * (-4π²) * ⟪ξ, w i⟫² + κ`.
* Symmetry is then immediate from realness of the symbol.
* For the deficiency spaces: if `u ∈ L²` satisfies `⟪P v, u⟫ = z ⟪v, u⟫` for all `v` in
  the core and `Im z ≠ 0`, put `g = 𝓕 u`.  Given any smooth compactly supported real
  `χ`, the function `ψ = χ / (symbol - conj z)` is again smooth with compact support
  (the denominator never vanishes because the symbol is real), hence Schwartz, and
  testing against `v = 𝓕⁻¹ ψ` gives `∫ χ • g = 0`.  As `χ` is arbitrary, `g = 0`, so
  `u = 0`.

Everything is proved in the general setting of a finite-dimensional real inner product
space `V` and an arbitrary finite family of directions `w : ι → V` with real
coefficients `c : ι → ℝ`; the Minkowski signature `c = (-1, 1, …, 1)` gives the wave
operator, and `c = (1, …, 1)` gives the Laplacian.

Essential self-adjointness is expressed with the deficiency-space predicates of
`BookProof.ChapterFarisLavine` (`BookProof.FarisLavine.EssentiallySelfAdjointOn`), which
are used throughout this project.
-/

namespace BookProof.StrichartzWave

open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

/-! ## The operator and its symbol -/

/-- The second directional derivative `∂_m ∂_m` as a continuous linear map on Schwartz
space. -/
noncomputable def secondDeriv (m : V) : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ) :=
  lineDerivOpCLM ℂ 𝓢(V, ℂ) m ∘L lineDerivOpCLM ℂ 𝓢(V, ℂ) m

/-- The constant-coefficient operator `∑ i, c i • ∂_{w i}² + κ` on Schwartz space.  For the
Minkowski signature `c = (-1, 1, …, 1)` and the standard coordinate directions this is the
d'Alembertian `□ = -∂_t² + Δ_x` plus the constant potential `κ`. -/
noncomputable def constCoeffOp (c : ι → ℝ) (w : ι → V) (κ : ℝ) : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ) :=
  (∑ i, (c i : ℂ) • secondDeriv (w i)) + (κ : ℂ) • ContinuousLinearMap.id ℂ 𝓢(V, ℂ)

/-- The (real!) symbol of `constCoeffOp c w κ`: with Mathlib's Fourier convention
`𝓕 f ξ = ∫ e^{-2πi⟪x,ξ⟫} f x`, the operator `∂_m²` becomes multiplication by
`-4π²⟪ξ, m⟫²`. -/
noncomputable def symbolFn (c : ι → ℝ) (w : ι → V) (κ : ℝ) (x : V) : ℝ :=
  (∑ i, c i * (-4 * Real.pi ^ 2) * (inner ℝ x (w i)) ^ 2) + κ

lemma fourier_secondDeriv_apply (f : 𝓢(V, ℂ)) (m : V) (x : V) :
    (𝓕 (secondDeriv m f) : 𝓢(V, ℂ)) x
      = ((-4 * Real.pi ^ 2 * (inner ℝ x m) ^ 2 : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x := by
  have h : (inner ℝ · m : V → ℝ).HasTemperateGrowth := ((innerSL ℝ).flip m).hasTemperateGrowth
  change (𝓕 (∂_{m} (∂_{m} f) : 𝓢(V, ℂ)) : 𝓢(V, ℂ)) x = _
  rw [fourier_lineDerivOp_eq, fourier_lineDerivOp_eq]
  simp only [h, smulLeftCLM_apply, SchwartzMap.smul_apply, smul_eq_mul, Complex.real_smul,
    Complex.ofReal_mul, Complex.ofReal_neg, Complex.ofReal_pow, Complex.ofReal_ofNat]
  rw [show ((2 : ℂ) * Real.pi * Complex.I) * (((inner ℝ x m : ℝ) : ℂ) *
      (((2 : ℂ) * Real.pi * Complex.I) * (((inner ℝ x m : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x))) =
      (Complex.I ^ 2) * (4 * (Real.pi : ℂ) ^ 2 * ((inner ℝ x m : ℝ) : ℂ) ^ 2 *
        (𝓕 f : 𝓢(V, ℂ)) x) by ring, Complex.I_sq]
  ring

/-- Under the Fourier transform the constant-coefficient operator becomes multiplication by
its symbol. -/
lemma fourier_constCoeffOp_apply (c : ι → ℝ) (w : ι → V) (κ : ℝ) (f : 𝓢(V, ℂ)) (x : V) :
    (𝓕 (constCoeffOp c w κ f) : 𝓢(V, ℂ)) x
      = ((symbolFn c w κ x : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x := by
  have hlin : (𝓕 (constCoeffOp c w κ f) : 𝓢(V, ℂ))
      = (∑ i, (c i : ℂ) • (𝓕 (secondDeriv (w i) f) : 𝓢(V, ℂ))) + (κ : ℂ) • (𝓕 f : 𝓢(V, ℂ)) := by
    change fourierTransformCLM ℂ (constCoeffOp c w κ f) = _
    simp [constCoeffOp]
  rw [hlin]
  simp only [SchwartzMap.add_apply, SchwartzMap.sum_apply, SchwartzMap.smul_apply, smul_eq_mul,
    fourier_secondDeriv_apply, symbolFn, Complex.ofReal_add, Complex.ofReal_sum,
    Complex.ofReal_mul, Complex.ofReal_neg, Complex.ofReal_pow, Complex.ofReal_ofNat,
    Finset.sum_mul, add_mul]
  congr 1
  exact Finset.sum_congr rfl fun i _ => by ring

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
lemma contDiff_symbolFn (c : ι → ℝ) (w : ι → V) (κ : ℝ) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (symbolFn c w κ) := by
  unfold symbolFn
  apply ContDiff.add _ contDiff_const
  apply ContDiff.sum
  intro i _
  exact contDiff_const.mul ((((innerSL ℝ).flip (w i)).contDiff).pow 2)

/-! ## The operator on `L²` -/

/-- The Schwartz core, as a submodule of `L²`. -/
noncomputable def schwartzDomain (V : Type*) [NormedAddCommGroup V] [InnerProductSpace ℝ V]
    [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] :
    Submodule ℂ (Lp ℂ 2 (volume : Measure V)) :=
  LinearMap.range (toLpCLM ℂ ℂ 2 (volume : Measure V)).toLinearMap

/-- Schwartz functions are in bijection with the Schwartz core of `L²`. -/
noncomputable def schwartzEquiv (V : Type*) [NormedAddCommGroup V] [InnerProductSpace ℝ V]
    [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] :
    𝓢(V, ℂ) ≃ₗ[ℂ] schwartzDomain V :=
  LinearEquiv.ofInjective (toLpCLM ℂ ℂ 2 (volume : Measure V)).toLinearMap
    (SchwartzMap.injective_toLp 2 (volume : Measure V))

/-- An operator on Schwartz space, viewed as an unbounded operator on `L²` with the Schwartz
core as its domain. -/
noncomputable def opL2 (T : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ)) :
    schwartzDomain V →ₗ[ℂ] Lp ℂ 2 (volume : Measure V) :=
  (toLpCLM ℂ ℂ 2 (volume : Measure V)).toLinearMap ∘ₗ T.toLinearMap ∘ₗ
    (schwartzEquiv V).symm.toLinearMap

@[simp] lemma opL2_apply (T : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ)) (f : 𝓢(V, ℂ)) :
    opL2 T (schwartzEquiv V f) = (T f).toLp 2 (volume : Measure V) := by
  simp [opL2, schwartzEquiv]

@[simp] lemma schwartzEquiv_coe (f : 𝓢(V, ℂ)) :
    ((schwartzEquiv V f : schwartzDomain V) : Lp ℂ 2 (volume : Measure V))
      = f.toLp 2 (volume : Measure V) := rfl

/-! ## Elementary `L²` identities -/

/-- The `L²` pairing of a Schwartz function with an `L²` function, as an integral. -/
lemma inner_toLp_left (f : 𝓢(V, ℂ)) (u : Lp ℂ 2 (volume : Measure V)) :
    (inner ℂ (f.toLp 2 (volume : Measure V)) u : ℂ)
      = ∫ x, (starRingEnd ℂ) (f x) * (u x) := by
  rw [MeasureTheory.L2.inner_def]
  refine integral_congr_ae ?_
  filter_upwards [f.coeFn_toLp 2 (volume : Measure V)] with x hx
  rw [hx]
  simp [RCLike.inner_apply, mul_comm]

/-- Products `conj f · u` of a Schwartz function and an `L²` function are integrable. -/
lemma integrable_conj_schwartz_mul (f : 𝓢(V, ℂ)) (u : Lp ℂ 2 (volume : Measure V)) :
    Integrable (fun x => (starRingEnd ℂ) (f x) * (u x)) (volume : Measure V) := by
  have h := MeasureTheory.L2.integrable_inner (𝕜 := ℂ) (f.toLp 2 (volume : Measure V)) u
  refine h.congr ?_
  filter_upwards [f.coeFn_toLp 2 (volume : Measure V)] with x hx
  rw [hx]
  simp [RCLike.inner_apply, mul_comm]

/-- The `L²` pairing of two Schwartz functions, computed on the Fourier side. -/
lemma inner_toLp_eq_integral_fourier (f g : 𝓢(V, ℂ)) :
    (inner ℂ (f.toLp 2 (volume : Measure V)) (g.toLp 2 (volume : Measure V)) : ℂ)
      = ∫ x, (starRingEnd ℂ) ((𝓕 f : 𝓢(V, ℂ)) x) * ((𝓕 g : 𝓢(V, ℂ)) x) := by
  rw [← MeasureTheory.Lp.inner_fourier_eq (f.toLp 2 (volume : Measure V))
      (g.toLp 2 (volume : Measure V)), SchwartzMap.toLp_fourier_eq, SchwartzMap.toLp_fourier_eq,
    inner_toLp_left]
  refine integral_congr_ae ?_
  filter_upwards [(𝓕 g : 𝓢(V, ℂ)).coeFn_toLp 2 (volume : Measure V)] with x hx
  rw [hx]

/-- The `L²` pairing of a Schwartz function with an `L²` function, on the Fourier side. -/
lemma inner_toLp_left_fourier (f : 𝓢(V, ℂ)) (u : Lp ℂ 2 (volume : Measure V)) :
    (inner ℂ (f.toLp 2 (volume : Measure V)) u : ℂ)
      = ∫ x, (starRingEnd ℂ) ((𝓕 f : 𝓢(V, ℂ)) x) * ((𝓕 u : Lp ℂ 2 (volume : Measure V)) x) := by
  rw [← MeasureTheory.Lp.inner_fourier_eq (f.toLp 2 (volume : Measure V)) u,
    SchwartzMap.toLp_fourier_eq, inner_toLp_left]

/-! ## Symmetry -/

/-- The constant-coefficient operator with real coefficients is symmetric on the Schwartz
core. -/
theorem constCoeffOp_symmetric (c : ι → ℝ) (w : ι → V) (κ : ℝ) :
    BookProof.FarisLavine.SymmetricOn (schwartzDomain V) (opL2 (constCoeffOp c w κ)) := by
  intro x y
  obtain ⟨f, rfl⟩ := (schwartzEquiv V).surjective x
  obtain ⟨g, rfl⟩ := (schwartzEquiv V).surjective y
  rw [opL2_apply, opL2_apply, schwartzEquiv_coe, schwartzEquiv_coe,
    inner_toLp_eq_integral_fourier, inner_toLp_eq_integral_fourier]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only [fourier_constCoeffOp_apply, map_mul, Complex.conj_ofReal]
  ring

/-! ## Vanishing deficiency spaces -/

/-- The key identity: for every Schwartz function `ψ`, testing the deficiency equation
against `𝓕⁻¹ ψ` gives `∫ conj ψ · (symbol - z) · 𝓕 u = 0`. -/
lemma integral_conj_mul_symbol_sub_eq_zero (c : ι → ℝ) (w : ι → V) (κ : ℝ) (z : ℂ)
    (u : Lp ℂ 2 (volume : Measure V))
    (hu : ∀ v : schwartzDomain V,
      (inner ℂ (opL2 (constCoeffOp c w κ) v) u : ℂ) = z * inner ℂ (v : Lp ℂ 2 _) u)
    (ψ : 𝓢(V, ℂ)) :
    ∫ x, (starRingEnd ℂ) (ψ x) * (((symbolFn c w κ x : ℝ) : ℂ) - z) *
      ((𝓕 u : Lp ℂ 2 (volume : Measure V)) x) = 0 := by
  set g : Lp ℂ 2 (volume : Measure V) := 𝓕 u with hg
  set f : 𝓢(V, ℂ) := 𝓕⁻ ψ with hfdef
  have hf : (𝓕 f : 𝓢(V, ℂ)) = ψ := fourier_fourierInv_eq ψ
  have h1 := hu (schwartzEquiv V f)
  rw [opL2_apply, schwartzEquiv_coe, inner_toLp_left_fourier, inner_toLp_left_fourier] at h1
  -- rewrite both integrands
  have hL : ∫ x, (starRingEnd ℂ) ((𝓕 (constCoeffOp c w κ f) : 𝓢(V, ℂ)) x) * (g x)
      = ∫ x, ((symbolFn c w κ x : ℝ) : ℂ) * ((starRingEnd ℂ) (ψ x) * (g x)) := by
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only [fourier_constCoeffOp_apply, hf, map_mul, Complex.conj_ofReal]
    ring
  rw [hL, hf] at h1
  -- integrability of the two pieces
  have hint1 : Integrable (fun x => (starRingEnd ℂ) (ψ x) * (g x)) (volume : Measure V) :=
    integrable_conj_schwartz_mul ψ g
  have hint2 : Integrable
      (fun x => ((symbolFn c w κ x : ℝ) : ℂ) * ((starRingEnd ℂ) (ψ x) * (g x)))
      (volume : Measure V) := by
    have := integrable_conj_schwartz_mul (𝓕 (constCoeffOp c w κ f) : 𝓢(V, ℂ)) g
    refine this.congr (Filter.Eventually.of_forall fun x => ?_)
    simp only [fourier_constCoeffOp_apply, hf, map_mul, Complex.conj_ofReal]
    ring
  have hcomb : ∫ x, (((symbolFn c w κ x : ℝ) : ℂ) * ((starRingEnd ℂ) (ψ x) * (g x))
      - z * ((starRingEnd ℂ) (ψ x) * (g x))) = 0 := by
    rw [integral_sub hint2 (hint1.const_mul z), MeasureTheory.integral_const_mul, h1]
    ring
  rw [← hcomb]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  ring

/-- **Vanishing deficiency spaces.**  For any non-real `z`, no non-zero `u ∈ L²` satisfies
the deficiency equation for the constant-coefficient operator. -/
theorem constCoeffOp_deficiencyTrivial (c : ι → ℝ) (w : ι → V) (κ : ℝ) {z : ℂ} (hz : z.im ≠ 0) :
    BookProof.FarisLavine.DeficiencyTrivialAt (schwartzDomain V)
      (opL2 (constCoeffOp c w κ)) z := by
  intro u hu
  have hz1 : ∀ x : V, ((symbolFn c w κ x : ℝ) : ℂ) - (starRingEnd ℂ) z ≠ 0 := by
    intro x hx
    exact hz (by simpa using congrArg Complex.im hx)
  have hz2 : ∀ x : V, ((symbolFn c w κ x : ℝ) : ℂ) - z ≠ 0 := by
    intro x hx
    exact hz (by simpa using congrArg Complex.im hx)
  -- Step 1: `∫ χ • 𝓕 u = 0` for every real smooth compactly supported `χ`.
  have main : ∀ χ : V → ℝ, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) χ → HasCompactSupport χ →
      ∫ x, χ x • ((𝓕 u : Lp ℂ 2 (volume : Measure V)) x) = 0 := by
    intro χ hχ hχc
    have hsmooth : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞)
        (fun x => (χ x : ℂ) * (((symbolFn c w κ x : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹) := by
      refine (Complex.ofRealCLM.contDiff.comp hχ).mul (ContDiff.inv ?_ hz1)
      exact (Complex.ofRealCLM.contDiff.comp (contDiff_symbolFn c w κ)).sub contDiff_const
    have hsupp : HasCompactSupport
        (fun x => (χ x : ℂ) * (((symbolFn c w κ x : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹) := by
      refine HasCompactSupport.mul_right ?_
      simpa using hχc.comp_left (g := fun r : ℝ => (r : ℂ)) (by simp)
    obtain ⟨ψ, hψcoe⟩ : ∃ ψ : 𝓢(V, ℂ), (ψ : V → ℂ) =
        fun x => (χ x : ℂ) * (((symbolFn c w κ x : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹ :=
      ⟨hsupp.toSchwartzMap hsmooth, rfl⟩
    have key := integral_conj_mul_symbol_sub_eq_zero c w κ z u hu ψ
    rw [← key]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    have hpx : ψ x = (χ x : ℂ) * (((symbolFn c w κ x : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹ :=
      congrFun hψcoe x
    have hc : (starRingEnd ℂ) (ψ x) * (((symbolFn c w κ x : ℝ) : ℂ) - z) = (χ x : ℂ) := by
      rw [hpx]
      simp only [map_mul, map_inv₀, map_sub, Complex.conj_ofReal, Complex.conj_conj]
      field_simp
      exact mul_div_cancel_right₀ _ (hz2 x)
    change χ x • ((𝓕 u : Lp ℂ 2 (volume : Measure V)) x)
      = (starRingEnd ℂ) (ψ x) * (((symbolFn c w κ x : ℝ) : ℂ) - z) *
        ((𝓕 u : Lp ℂ 2 (volume : Measure V)) x)
    rw [Complex.real_smul, ← hc]
  -- Step 2: conclude that `𝓕 u = 0`, hence `u = 0`.
  have hgloc : LocallyIntegrable
      (fun x => ((𝓕 u : Lp ℂ 2 (volume : Measure V)) x : ℂ)) (volume : Measure V) :=
    (Lp.memLp (𝓕 u : Lp ℂ 2 (volume : Measure V))).locallyIntegrable (by norm_num)
  have hae : ∀ᵐ x ∂(volume : Measure V), ((𝓕 u : Lp ℂ 2 (volume : Measure V)) x : ℂ) = 0 :=
    ae_eq_zero_of_integral_contDiff_smul_eq_zero hgloc (fun χ hχ hχc => main χ hχ hχc)
  have hg0 : (𝓕 u : Lp ℂ 2 (volume : Measure V)) = 0 := Lp.eq_zero_iff_ae_eq_zero.mpr hae
  have hnorm : ‖u‖ = 0 := by
    rw [← MeasureTheory.Lp.norm_fourier_eq u, hg0, norm_zero]
  exact norm_eq_zero.mp hnorm

/-- **Essential self-adjointness of constant-coefficient operators with real symbol** on the
Schwartz core of `L²(V)`. -/
theorem constCoeffOp_essentiallySelfAdjoint (c : ι → ℝ) (w : ι → V) (κ : ℝ) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain V)
      (opL2 (constCoeffOp c w κ)) :=
  ⟨constCoeffOp_deficiencyTrivial c w κ (by simp),
    constCoeffOp_deficiencyTrivial c w κ (by simp)⟩

/-! ## Smooth cut-off functions

The Fourier-multiplier proof above needs no cut-offs, but the cut-off functions of the
variable-coefficient (energy-estimate) theory are recorded here: for every radius `R`
there is a smooth compactly supported `χ` with values in `[0,1]` which equals `1` on the
ball of radius `R` and has a bounded gradient. -/

omit [MeasurableSpace V] [BorelSpace V] in
/-- For every radius `R` there is a smooth, compactly supported cut-off `χ` with values in
`[0,1]`, equal to `1` on the closed ball of radius `R`, supported in the ball of radius
`R + 1`, and with globally bounded gradient. -/
theorem exists_smooth_cutoff (R : ℝ) :
    ∃ χ : V → ℝ, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) χ ∧ HasCompactSupport χ ∧
      (∀ x, ‖x‖ ≤ R → χ x = 1) ∧ (∀ x, χ x ∈ Set.Icc (0 : ℝ) 1) ∧
      (∀ x, R + 1 ≤ ‖x‖ → χ x = 0) ∧ ∃ C : ℝ, ∀ x, ‖gradient χ x‖ ≤ C := by
  have hs : IsClosed {x : V | R + 1 ≤ ‖x‖} := isClosed_le continuous_const continuous_norm
  have ht : IsClosed (Metric.closedBall (0 : V) R) := Metric.isClosed_closedBall
  have hd : Disjoint {x : V | R + 1 ≤ ‖x‖} (Metric.closedBall (0 : V) R) := by
    rw [Set.disjoint_left]
    intro x hx hx'
    simp only [Set.mem_setOf_eq] at hx
    simp only [Metric.mem_closedBall, dist_zero_right] at hx'
    linarith
  obtain ⟨f, hf0, hf1, hfIcc⟩ :=
    exists_contMDiffMap_zero_one_of_isClosed (modelWithCornersSelf ℝ V) hs ht hd
  have hsmooth : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (⇑f) := contMDiff_iff_contDiff.mp f.contMDiff
  have hcs : HasCompactSupport (⇑f) := by
    apply HasCompactSupport.intro (isCompact_closedBall (0 : V) (R + 1))
    intro x hx
    apply hf0
    simp only [Metric.mem_closedBall, dist_zero_right, not_le] at hx
    simp only [Set.mem_setOf_eq]
    linarith
  refine ⟨⇑f, hsmooth, hcs, fun x hx => hf1 (by simpa [dist_zero_right] using hx), hfIcc,
    fun x hx => hf0 hx, ?_⟩
  have hgrad : ∀ x : V, gradient (⇑f) x = (InnerProductSpace.toDual ℝ V).symm (fderiv ℝ (⇑f) x) :=
    fun _ => rfl
  have hgcs : HasCompactSupport (fun x => gradient (⇑f) x) := by
    simp only [hgrad]
    exact (hcs.fderiv ℝ).comp_left (g := fun L => (InnerProductSpace.toDual ℝ V).symm L) (by simp)
  have hgcont : Continuous (fun x => gradient (⇑f) x) := by
    simp only [hgrad]
    exact (InnerProductSpace.toDual ℝ V).symm.continuous.comp (hsmooth.continuous_fderiv (by simp))
  exact hgcs.exists_bound_of_continuous hgcont

/-! ## The wave operator on spacetime -/

/-- Spacetime `ℝ^{1+n}`: one time coordinate (index `0`) and `n` space coordinates. -/
abbrev SpaceTime (n : ℕ) := EuclideanSpace ℝ (Fin (1 + n))

/-- The Minkowski signature `(-1, +1, …, +1)`. -/
def minkowskiSign (n : ℕ) : Fin (1 + n) → ℝ := fun i => if i = 0 then -1 else 1

/-- The coordinate directions of spacetime. -/
noncomputable def coordDir (n : ℕ) : Fin (1 + n) → SpaceTime n := fun i =>
  EuclideanSpace.single i 1

/-- The d'Alembertian `□ = -∂_t² + Δ_x` with a real constant potential `κ`, as an operator on
the Schwartz space of spacetime. -/
noncomputable def waveOp (n : ℕ) (κ : ℝ) : 𝓢(SpaceTime n, ℂ) →L[ℂ] 𝓢(SpaceTime n, ℂ) :=
  constCoeffOp (minkowskiSign n) (coordDir n) κ

/-- The wave operator is symmetric on the Schwartz core. -/
theorem wave_symmetric (n : ℕ) (κ : ℝ) :
    BookProof.FarisLavine.SymmetricOn (schwartzDomain (SpaceTime n)) (opL2 (waveOp n κ)) :=
  constCoeffOp_symmetric _ _ _

/-- **Strichartz-type theorem.**  The wave operator `□ + κ = -∂_t² + Δ_x + κ` with a real
constant potential is essentially self-adjoint on the Schwartz core of `L²(ℝ^{1+n})`: both
deficiency spaces vanish, so it has a unique self-adjoint extension. -/
theorem wave_essentiallySelfAdjoint (n : ℕ) (κ : ℝ) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain (SpaceTime n))
      (opL2 (waveOp n κ)) :=
  constCoeffOp_essentiallySelfAdjoint _ _ _

end BookProof.StrichartzWave
