-- Generated from ChapterStrichartzWave.lean — solution of BookProof.StrichartzWave.constCoeffOp_symmetric
import Mathlib
import Definitions.Def_ChapterStrichartzWave
import Theorems.Thm_BookProof_StrichartzWave_fourier_constCoeffOp_apply
import Theorems.Thm_BookProof_StrichartzWave_opL2_apply
import Theorems.Thm_BookProof_StrichartzWave_schwartzEquiv_coe
import Theorems.Thm_BookProof_StrichartzWave_inner_toLp_eq_integral_fourier
open BookProof.StrichartzWave




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

set_option maxHeartbeats 1000000 in
 :=
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
    exact congrArg (fun y => (T y).toLp 2 (volume : Measure V))
      (LinearEquiv.symm_apply_apply (schwartzEquiv V) f)
  
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
    refine integral_congr_ae (F
