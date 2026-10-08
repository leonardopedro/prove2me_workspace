import Definitions.Def_ChapterNsSpatialMomentumMultiplier
import Mathlib


/-!
# The partial (spatial-only) Fourier transform on the fibred one-particle space

This module continues item 1 of the Navier–Stokes plan items of `CONSOLIDATED_PLAN.md`, *the
spatial Fourier unitary and the diagonal derivative*.  The module
`BookProof.ChapterNsSpatialMomentumMultiplier` did the multiplier half on `L²(V)`; the part left
open there was the **partial** transform — the one that transforms the spatial variable and leaves
the fibre variable alone.

The fibred model used here is the vector-valued one: the one-particle space is
`L²(V; F) = Lp F 2 (volume : Measure V)`, functions of the spatial variable `x ∈ V` with values in
the fibre Hilbert space `F`; for the Navier–Stokes route `F` is itself an `L²` space of the fibre
variable, `F = L²(W)` (§4 below).  On this space:

* `partialFourier` — the Plancherel identification `L²(V; F) ≃ₗᵢ[ℂ] L²(V; F)` in the *spatial*
  variable only, with `partialFourier_norm` and `partialFourier_inner` its unitarity;
* `partialFourier_fibreOp` — **the transform leaves the fibre alone**: it commutes with the
  pointwise action of *every* bounded operator of the fibre, `𝓕 ∘ (T ·) = (T ·) ∘ 𝓕`.  This is the
  precise content of "partial": nothing at all happens in the fibre variable.  Proved by density
  of the Schwartz functions from the Schwartz-level identity `fourier_postcompCLM`;
* `fourier_vecMomentumOp_apply` — **the diagonal spatial derivative**: for a fibre-valued Schwartz
  function the transform carries `π_m = −i ∂_m` to multiplication by the real symbol
  `2π ⟪ξ, m⟫`, exactly the scalar symbol of `BookProof.FourierMultiplierEsa`, in particular one
  that does not involve the fibre;
* `postcompCLM_vecMomentumOp` — the spatial derivative itself commutes with every fibre operator;
* §4 — the concrete Navier–Stokes instance `F = L²(W)`: `nsPartialFourier` is the spatial-only
  transform of `L²(V; L²(W))`, `nsPartialFourier_fibreOp` says it commutes with every operator of
  the fibre variable, and `nsPartialFourier_fibreFourier` that it commutes in particular with the
  Fourier transform *of the fibre variable*, whose composite with it is the full transform in both
  variables (`nsPartialFourier_comp_fibreFourier_eq`).

Auxiliary and of independent use: `postcompCLM`, the postcomposition of a Schwartz function with a
continuous linear map of the target, which Mathlib does not provide, together with its Fourier
(`fourier_postcompCLM`), `L²` (`toLp_postcompCLM`) and derivative (`postcompCLM_lineDerivOp`)
compatibilities.

**The model.**  The model used here is the vector-valued one, `L²(V; L²(W))`.  Its
measure-theoretic identification with the scalar `L²(V × W)` — which Mathlib does not have — is
now formalized in `BookProof.ChapterNsScalarVectorCurry` (`curryLI`, pinned down on the
generators by `curryLI_fibMk` and `curryLI_indicator_prod`), and
`BookProof.ChapterNsScalarFourier` transports the transform of this module to the scalar space
by it (`nsScalarFourier`, with `nsScalarFourier_scalarFibreOp` for the fibre-blindness).

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.NsPartialFourier

open MeasureTheory SchwartzMap FourierTransform LineDeriv

noncomputable section

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

/-! ## 1. Postcomposition of a Schwartz function with an operator of the target -/

section Postcomp

variable {F G : Type*} [NormedAddCommGroup F] [NormedSpace ℂ F]
  [NormedAddCommGroup G] [NormedSpace ℂ G]

/-- **Postcomposition with a continuous linear map of the target**, as a continuous linear map of
Schwartz spaces: `f ↦ T ∘ f`.  (Mathlib has precomposition, `SchwartzMap.compCLM`, but not this.) -/
def postcompCLM (T : F →L[ℂ] G) : 𝓢(V, F) →L[ℂ] 𝓢(V, G) :=
  SchwartzMap.bilinLeftCLM (((ContinuousLinearMap.lsmul ℂ ℂ : ℂ →L[ℂ] G →L[ℂ] G).flip).comp T)
    (g := fun _ : V => (1 : ℂ)) (Function.HasTemperateGrowth.const _)

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
@[simp] theorem postcompCLM_apply (T : F →L[ℂ] G) (f : 𝓢(V, F)) (x : V) :
    postcompCLM T f x = T (f x) := by
  change (((ContinuousLinearMap.lsmul ℂ ℂ : ℂ →L[ℂ] G →L[ℂ] G).flip).comp T) (f x) (1 : ℂ)
    = T (f x)
  simp









end Postcomp

/-! ## 2. The partial transform and its fibre-blindness -/

variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

variable (V F) in
/-- **The partial (spatial-only) Fourier transform** of the fibred one-particle space
`L²(V; F)`: Plancherel in the spatial variable `x ∈ V`, with the fibre `F` untouched. -/
def partialFourier : (Lp F 2 (volume : Measure V)) ≃ₗᵢ[ℂ] (Lp F 2 (volume : Measure V)) :=
  MeasureTheory.Lp.fourierTransformₗᵢ V F

@[simp] theorem partialFourier_apply (v : Lp F 2 (volume : Measure V)) :
    partialFourier V F v = 𝓕 v := rfl





variable (V) in
/-- An operator **of the fibre alone**, acting pointwise in the spatial variable. -/
def fibreOp (T : F →L[ℂ] G) :
    Lp F 2 (volume : Measure V) →L[ℂ] Lp G 2 (volume : Measure V) :=
  T.compLpL 2 (volume : Measure V)





/-! ## 3. The diagonal spatial derivative in the fibred space -/

/-- The spatial momentum operator `π_m = −i ∂_m` on fibre-valued Schwartz functions. -/
def vecMomentumOp (m : V) : 𝓢(V, F) →L[ℂ] 𝓢(V, F) :=
  (-Complex.I) • lineDerivOpCLM ℂ 𝓢(V, F) m

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] [CompleteSpace F] in
@[simp] theorem vecMomentumOp_apply (m : V) (f : 𝓢(V, F)) :
    vecMomentumOp m f = (-Complex.I) • (∂_{m} f : 𝓢(V, F)) := rfl

ONSOLIDATED_PLAN.md`, *the
spatial Fourier unitary and the diagonal derivative*.  The module
`BookProof.ChapterNsSpatialMomentumMultiplier` did the multiplier half on `L²(V)`; the part left
open there was the **partial** transform — the one that transforms the spatial variable and leaves
the fibre variable alone.

The fibred model used here is the vector-valued one: the one-particle space is
`L²(V; F) = Lp F 2 (volume : Measure V)`, functions of the spatial variable `x ∈ V` with values in
the fibre Hilbert space `F`; for the Navier–Stokes route `F` is itself an `L²` space of the fibre
variable, `F = L²(W)` (§4 below).  On this space:

* `partialFourier` — the Plancherel identification `L²(V; F) ≃ₗᵢ[ℂ] L²(V; F)` in the *spatial*
  variable only, with `partialFourier_norm` and `partialFourier_inner` its unitarity;
* `partialFourier_fibreOp` — **the transform leaves the fibre alone**: it commutes with the
  pointwise action of *every* bounded operator of the fibre, `𝓕 ∘ (T ·) = (T ·) ∘ 𝓕`.  This is the
  precise content of "partial": nothing at all happens in the fibre variable.  Proved by density
  of the Schwartz functions from the Schwartz-level identity `fourier_postcompCLM`;
* `fourier_vecMomentumOp_apply` — **the diagonal spatial derivative**: for a fibre-valued Schwartz
  function the transform carries `π_m = −i ∂_m` to multiplication by the real symbol
  `2π ⟪ξ, m⟫`, exactly the scalar symbol of `BookProof.FourierMultiplierEsa`, in particular one
  that does not involve the fibre;
* `postcompCLM_vecMomentumOp` — the spatial derivative itself commutes with every fibre operator;
* §4 — the concrete Navier–Stokes instance `F = L²(W)`: `nsPartialFourier` is the spatial-only
  transform of `L²(V; L²(W))`, `nsPartialFourier_fibreOp` says it commutes with every operator of
  the fibre variable, and `nsPartialFourier_fibreFourier` that it commutes in particular with the
  Fourier transform *of the fibre variable*, whose composite with it is the full transform in both
  variables (`nsPartialFourier_comp_fibreFourier_eq`).

Auxiliary and of independent use: `postcompCLM`, the postcomposition of a Schwartz function with a
continuous linear map of the target, which Mathlib does not provide, together with its Fourier
(`fourier_postcompCLM`), `L²` (`toLp_postcompCLM`) and derivative (`postcompCLM_lineDerivOp`)
compatibilities.

**The model.**  The model used here is the vector-valued one, `L²(V; L²(W))`.  Its
measure-theoretic identification with the scalar `L²(V × W)` — which Mathlib does not have — is
now formalized in `BookProof.ChapterNsScalarVectorCurry` (`curryLI`, pinned down on the
generators by `curryLI_fibMk` and `curryLI_indicator_prod`), and
`BookProof.ChapterNsScalarFourier` transports the transform of this module to the scalar space
by it (`nsScalarFourier`, with `nsScalarFourier_scalarFibreOp` for the fibre-blindness).

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.NsPartialFourier

open MeasureTheory SchwartzMap FourierTransform LineDeriv

noncomputable section

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

/-! ## 1. Postcomposition of a Schwartz function with an operator of the target -/

section Postcomp

variable {F G : Type*} [NormedAddCommGroup F] [NormedSpace ℂ F]
  [NormedAddCommGroup G] [NormedSpace ℂ G]

/-- **Postcomposition with a continuous linear map of the target**, as a continuous linear map of
Schwartz spaces: `f ↦ T ∘ f`.  (Mathlib has precomposition, `SchwartzMap.compCLM`, but not this.) -/
def postcompCLM (T : F →L[ℂ] G) : 𝓢(V, F) →L[ℂ] 𝓢(V, G) :=
  SchwartzMap.bilinLeftCLM (((ContinuousLinearMap.lsmul ℂ ℂ : ℂ →L[ℂ] G →L[ℂ] G).flip).comp T)
    (g := fun _ : V => (1 : ℂ)) (Function.HasTemperateGrowth.const _)

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
@[simp] theorem postcompCLM_apply (T : F →L[ℂ] G) (f : 𝓢(V, F)) (x : V) :
    postcompCLM T f x = T (f x) := by
  change (((ContinuousLinearMap.lsmul ℂ ℂ : ℂ →L[ℂ] G →L[ℂ] G).flip).comp T) (f x) (1 : ℂ)
    = T (f x)
  simp

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
/-- The spatial line derivative acts only on the spatial variable, so it commutes with
postcomposition by an operator of the target. -/
theorem postcompCLM_lineDerivOp (T : F →L[ℂ] G) (f : 𝓢(V, F)) (m : V) :
    postcompCLM T (∂_{m} f : 𝓢(V, F)) = (∂_{m} (postcompCLM T f) : 𝓢(V, G)) := by
  ext x
  have hcoe : ((postcompCLM T f : 𝓢(V, G)) : V → G) = fun y => T (f y) :=
    funext fun y => postcompCLM_apply T f y
  have hf : HasFDerivAt (fun y => (f : V → F) y) (fderiv ℝ (f : V → F) x) x :=
    f.differentiableAt.hasFDerivAt
  have hT : HasFDerivAt (fun y => T (f y))
      ((T.restrictScalars ℝ).comp (fderiv ℝ (f : V → F) x)) x :=
    (T.restrictScalars ℝ).hasFDerivAt.comp x hf
  rw [postcompCLM_apply, lineDerivOp_apply_eq_fderiv, lineDerivOp_apply_eq_fderiv, hcoe,
    hT.fderiv]
  rfl

/-- **The Fourier transform commutes with postcomposition** — the transform is taken in the
spatial variable, and an operator of the target is invisible to it. -/
theorem fourier_postcompCLM_apply [CompleteSpace F] [CompleteSpace G]
    (T : F →L[ℂ] G) (f : 𝓢(V, F)) (x : V) :
    (𝓕 (postcompCLM T f) : 𝓢(V, G)) x = T ((𝓕 f : 𝓢(V, F)) x) := by
  rw [SchwartzMap.fourier_coe, SchwartzMap.fourier_coe, Real.fourier_eq, Real.fourier_eq]
  have hint : Integrable (fun v : V => (𝐞 (-inner ℝ v x) : ℂ) • f v) volume :=
    (Real.fourierIntegral_convergent_iff _).mpr f.integrable
  have h := ContinuousLinearMap.integral_comp_comm (T.restrictScalars ℝ) hint
  simp only [ContinuousLinearMap.coe_restrictScalars'] at h
  simp only [Circle.smul_def]
  rw [← h]
  refine integral_congr_ae (Filter.Eventually.of_forall fun y => ?_)
  simp

theorem fourier_postcompCLM [CompleteSpace F] [CompleteSpace G] (T : F →L[ℂ] G) (f : 𝓢(V, F)) :
    (𝓕 (postcompCLM T f) : 𝓢(V, G)) = postcompCLM T (𝓕 f : 𝓢(V, F)) := by
  ext x
  simpa using fourier_postcompCLM_apply T f x

/-- Postcomposition on Schwartz space is the pointwise action of `T` on `L²`. -/
theorem toLp_postcompCLM (T : F →L[ℂ] G) (f : 𝓢(V, F)) :
    (postcompCLM T f).toLp 2 (volume : Measure V)
      = T.compLp (f.toLp 2 (volume : Measure V)) := by
  refine (MeasureTheory.Lp.ext_iff).2 ?_
  filter_upwards [(postcompCLM T f).coeFn_toLp 2 (volume : Measure V),
    T.coeFn_compLp (f.toLp 2 (volume : Measure V)),
    f.coeFn_toLp 2 (volume : Measure V)] with x hx hTx hfx
  rw [hx, hTx, hfx, postcompCLM_apply]

end Postcomp

/-! ## 2. The partial transform and its fibre-blindness -/

variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

variable (V F) in
/-- **The partial (spatial-only) Fourier transform** of the fibred one-particle space
`L²(V; F)`: Plancherel in the spatial variable `x ∈ V`, with the fibre `F` untouched. -/
def partialFourier : (Lp F 2 (volume : Measure V)) ≃ₗᵢ[ℂ] (Lp F 2 (volume : Measure V)) :=
  MeasureTheory.Lp.fourierTransformₗᵢ V F

@[simp] theorem partialFourier_apply (v : Lp F 2 (volume : Measure V)) :
    partialFourier V F v = 𝓕 v := rfl

/-- Plancherel for the partial transform. -/
theorem partialFourier_norm (v : Lp F 2 (volume : Measure V)) :
    ‖partialFourier V F v‖ = ‖v‖ := (partialFourier V F).norm_map v

/-- The partial transform preserves the inner product. -/
theorem partialFourier_inner (v u : Lp F 2 (volume : Measure V)) :
    (inner ℂ (partialFourier V F v) (partialFourier V F u) : ℂ) = inner ℂ v u :=
  (partialFourier V F).inner_map_map v u

variable (V) in
/-- An operator **of the fibre alone**, acting pointwise in the spatial variable. -/
def fibreOp (T : F →L[ℂ] G) :
    Lp F 2 (volume : Measure V) →L[ℂ] Lp G 2 (volume : Measure V) :=
  T.compLpL 2 (volume : Measure V)

omit [CompleteSpace F] [CompleteSpace G] in
theorem fibreOp_apply (T : F →L[ℂ] G) (f : Lp F 2 (volume : Measure V)) :
    fibreOp V T f = T.compLp f := rfl

/-- **The partial transform leaves the fibre alone.**  It commutes with the pointwise action of
every bounded operator of the fibre: transforming the spatial variable and acting in the fibre are
independent operations. -/
theorem partialFourier_fibreOp (T : F →L[ℂ] G) (f : Lp F 2 (volume : Measure V)) :
    partialFourier V G (fibreOp V T f) = fibreOp V T (partialFourier V F f) := by
  have hcont₁ : Continuous fun f : Lp F 2 (volume : Measure V) =>
      partialFourier V G (fibreOp V T f) :=
    (partialFourier V G).continuous.comp (fibreOp V T).continuous
  have hcont₂ : Continuous fun f : Lp F 2 (volume : Measure V) =>
      fibreOp V T (partialFourier V F f) :=
    (fibreOp V T).continuous.comp (partialFourier V F).continuous
  have hdense : Dense (Set.range (SchwartzMap.toLpCLM ℝ F 2 (volume : Measure V))) :=
    SchwartzMap.denseRange_toLpCLM (F := F) (μ := (volume : Measure V)) ENNReal.ofNat_ne_top
  refine congrFun (Continuous.ext_on hdense hcont₁ hcont₂ ?_) f
  rintro _ ⟨g, rfl⟩
  simp only [SchwartzMap.toLpCLM_apply, partialFourier_apply, fibreOp_apply]
  rw [← toLp_postcompCLM, SchwartzMap.toLp_fourier_eq, SchwartzMap.toLp_fourier_eq,
    ← toLp_postcompCLM, fourier_postcompCLM]

/-! ## 3. The diagonal spatial derivative in the fibred space -/

/-- The spatial momentum operator `π_m = −i ∂_m` on fibre-valued Schwartz functions. -/
def vecMomentumOp (m : V) : 𝓢(V, F) →L[ℂ] 𝓢(V, F) :=
  (-Complex.I) • lineDerivOpCLM ℂ 𝓢(V, F) m

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] [CompleteSpace F] in
@[simp] theorem vecMomentumOp_apply (m : V) (f : 𝓢(V, F)) :
    vecMomentumOp m f = (-Complex.I) • (∂_{m} f : 𝓢(V, F)) := rfl

omit [CompleteSpace F] in
/-- **The diagonal derivative.**  Under the partial transform the spatial momentum `−i ∂_m`
becomes multiplication by the real symbol `2π ⟪ξ, m⟫` — the same symbol as in the scalar case, in
particular independent of the fibre. -/
theorem fourier_vecMomentumOp_apply (m : V) (f : 𝓢(V, F)) (x : V) :
    (𝓕 (vecMomentumOp m f) : 𝓢(V, F)) x
      = ((2 * Real.pi * (inner ℝ x m) : ℝ) : ℂ) • (𝓕 f : 𝓢(V, F)) x := by
  have h : (inner ℝ · m : V → ℝ).HasTemperateGrowth := ((innerSL ℝ).flip m).hasTemperateGrowth
  have hlin : (𝓕 (vecMomentumOp m f) : 𝓢(V, F))
      = (-Complex.I) • (𝓕 (∂_{m} f : 𝓢(V, F)) : 𝓢(V, F)) := by
    change fourierTransformCLM ℂ (vecMomentumOp m f) = _
    simp [vecMomentumOp]
  rw [hlin]
  simp only [SchwartzMap.smul_apply, fourier_lineDerivOp_eq, h, smulLeftCLM_apply,
    Complex.ofReal_mul, Complex.ofReal_ofNat, smul_smul]
  rw [← Complex.coe_smul, smul_smul]
  congr 1
  rw [show (-Complex.I * (2 * (Real.pi : ℂ) * Complex.I)) * ((inner ℝ x m : ℝ) : ℂ)
      = (-(Complex.I * Complex.I)) * (2 * (Real.pi : ℂ) * ((inner ℝ x m : ℝ) : ℂ)) by ring,
    show Complex.I * Complex.I = -1 from Complex.I_mul_I]
  ring

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] [CompleteSpace F]
  [CompleteSpace G] in
/-- The spatial momentum commutes with every operator of the fibre. -/
theorem postcompCLM_vecMomentumOp (T : F →L[ℂ] G) (m : V) (f : 𝓢(V, F)) :
    postcompCLM T (vecMomentumOp m f) = vecMomentumOp m (postcompCLM T f) := by
  calc postcompCLM T (vecMomentumOp m f)
      = (-Complex.I) • postcompCLM T (∂_{m} f : 𝓢(V, F)) := by
        rw [vecMomentumOp_apply, map_smul]
    _ = vecMomentumOp m (postcompCLM T f) := by
        rw [postcompCLM_lineDerivOp, vecMomentumOp_apply]

/-! ## 4. The Navier–Stokes instance: the fibre is an `L²` space -/

section Concrete

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [FiniteDimensional ℝ W]
  [MeasurableSpace W] [BorelSpace W]

variable (V W) in
/-- **The spatial-only Fourier transform of the fibred Navier–Stokes one-particle space.**  The
space is `L²(V; L²(W))` — square-integrable functions of the spatial variable `x ∈ V` with values
in the fibre space `L²(W)` of the fibre variable `u ∈ W` — and the transform acts in `x` only. -/
def nsPartialFourier :
    (Lp (Lp ℂ 2 (volume : Measure W)) 2 (volume : Measure V)) ≃ₗᵢ[ℂ]
      (Lp (Lp ℂ 2 (volume : Measure W)) 2 (volume : Measure V)) :=
  partialFourier V (Lp ℂ 2 (volume : Measure W))





variable (W) in
/-- The Fourier transform **of the fibre variable**, as an operator of the fibre. -/
def fibreFourierCLM : Lp ℂ 2 (volume : Measure W) →L[ℂ] Lp ℂ 2 (volume : Measure W) :=
  (MeasureTheory.Lp.fourierTransformₗᵢ W ℂ).toLinearIsometry.toContinuousLinearMapry and the diagonal derivative*.  The module
`BookProof.ChapterNsSpatialMomentumMultiplier` did the multiplier half on `L²(V)`; the part left
open there was the **partial** transform — the one that transforms the spatial variable and leaves
the fibre variable alone.

The fibred model used here is the vector-valued one: the one-particle space is
`L²(V; F) = Lp F 2 (volume : Measure V)`, functions of the spatial variable `x ∈ V` with values in
the fibre Hilbert space `F`; for the Navier–Stokes route `F` is itself an `L²` space of the fibre
variable, `F = L²(W)` (§4 below).  On this space:

* `partialFourier` — the Plancherel identification `L²(V; F) ≃ₗᵢ[ℂ] L²(V; F)` in the *spatial*
  variable only, with `partialFourier_norm` and `partialFourier_inner` its unitarity;
* `partialFourier_fibreOp` — **the transform leaves the fibre alone**: it commutes with the
  pointwise action of *every* bounded operator of the fibre, `𝓕 ∘ (T ·) = (T ·) ∘ 𝓕`.  This is the
  precise content of "partial": nothing at all happens in the fibre variable.  Proved by density
  of the Schwartz functions from the Schwartz-level identity `fourier_postcompCLM`;
* `fourier_vecMomentumOp_apply` — **the diagonal spatial derivative**: for a fibre-valued Schwartz
  function the transform carries `π_m = −i ∂_m` to multiplication by the real symbol
  `2π ⟪ξ, m⟫`, exactly the scalar symbol of `BookProof.FourierMultiplierEsa`, in particular one
  that does not involve the fibre;
* `postcompCLM_vecMomentumOp` — the spatial derivative itself commutes with every fibre operator;
* §4 — the concrete Navier–Stokes instance `F = L²(W)`: `nsPartialFourier` is the spatial-only
  transform of `L²(V; L²(W))`, `nsPartialFourier_fibreOp` says it commutes with every operator of
  the fibre variable, and `nsPartialFourier_fibreFourier` that it commutes in particular with the
  Fourier transform *of the fibre variable*, whose composite with it is the full transform in both
  variables (`nsPartialFourier_comp_fibreFourier_eq`).

Auxiliary and of independent use: `postcompCLM`, the postcomposition of a Schwartz function with a
continuous linear map of the target, which Mathlib does not provide, together with its Fourier
(`fourier_postcompCLM`), `L²` (`toLp_postcompCLM`) and derivative (`postcompCLM_lineDerivOp`)
compatibilities.

**The model.**  The model used here is the vector-valued one, `L²(V; L²(W))`.  Its
measure-theoretic identification with the scalar `L²(V × W)` — which Mathlib does not have — is
now formalized in `BookProof.ChapterNsScalarVectorCurry` (`curryLI`, pinned down on the
generators by `curryLI_fibMk` and `curryLI_indicator_prod`), and
`BookProof.ChapterNsScalarFourier` transports the transform of this module to the scalar space
by it (`nsScalarFourier`, with `nsScalarFourier_scalarFibreOp` for the fibre-blindness).

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.NsPartialFourier

open MeasureTheory SchwartzMap FourierTransform LineDeriv

noncomputable section

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

/-! ## 1. Postcomposition of a Schwartz function with an operator of the target -/

section Postcomp

variable {F G : Type*} [NormedAddCommGroup F] [NormedSpace ℂ F]
  [NormedAddCommGroup G] [NormedSpace ℂ G]

/-- **Postcomposition with a continuous linear map of the target**, as a continuous linear map of
Schwartz spaces: `f ↦ T ∘ f`.  (Mathlib has precomposition, `SchwartzMap.compCLM`, but not this.) -/
def postcompCLM (T : F →L[ℂ] G) : 𝓢(V, F) →L[ℂ] 𝓢(V, G) :=
  SchwartzMap.bilinLeftCLM (((ContinuousLinearMap.lsmul ℂ ℂ : ℂ →L[ℂ] G →L[ℂ] G).flip).comp T)
    (g := fun _ : V => (1 : ℂ)) (Function.HasTemperateGrowth.const _)

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
@[simp] theorem postcompCLM_apply (T : F →L[ℂ] G) (f : 𝓢(V, F)) (x : V) :
    postcompCLM T f x = T (f x) := by
  change (((ContinuousLinearMap.lsmul ℂ ℂ : ℂ →L[ℂ] G →L[ℂ] G).flip).comp T) (f x) (1 : ℂ)
    = T (f x)
  simp

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
/-- The spatial line derivative acts only on the spatial variable, so it commutes with
postcomposition by an operator of the target. -/
theorem postcompCLM_lineDerivOp (T : F →L[ℂ] G) (f : 𝓢(V, F)) (m : V) :
    postcompCLM T (∂_{m} f : 𝓢(V, F)) = (∂_{m} (postcompCLM T f) : 𝓢(V, G)) := by
  ext x
  have hcoe : ((postcompCLM T f : 𝓢(V, G)) : V → G) = fun y => T (f y) :=
    funext fun y => postcompCLM_apply T f y
  have hf : HasFDerivAt (fun y => (f : V → F) y) (fderiv ℝ (f : V → F) x) x :=
    f.differentiableAt.hasFDerivAt
  have hT : HasFDerivAt (fun y => T (f y))
      ((T.restrictScalars ℝ).comp (fderiv ℝ (f : V → F) x)) x :=
    (T.restrictScalars ℝ).hasFDerivAt.comp x hf
  rw [postcompCLM_apply, lineDerivOp_apply_eq_fderiv, lineDerivOp_apply_eq_fderiv, hcoe,
    hT.fderiv]
  rfl

/-- **The Fourier transform commutes with postcomposition** — the transform is taken in the
spatial variable, and an operator of the target is invisible to it. -/
theorem fourier_postcompCLM_apply [CompleteSpace F] [CompleteSpace G]
    (T : F →L[ℂ] G) (f : 𝓢(V, F)) (x : V) :
    (𝓕 (postcompCLM T f) : 𝓢(V, G)) x = T ((𝓕 f : 𝓢(V, F)) x) := by
  rw [SchwartzMap.fourier_coe, SchwartzMap.fourier_coe, Real.fourier_eq, Real.fourier_eq]
  have hint : Integrable (fun v : V => (𝐞 (-inner ℝ v x) : ℂ) • f v) volume :=
    (Real.fourierIntegral_convergent_iff _).mpr f.integrable
  have h := ContinuousLinearMap.integral_comp_comm (T.restrictScalars ℝ) hint
  simp only [ContinuousLinearMap.coe_restrictScalars'] at h
  simp only [Circle.smul_def]
  rw [← h]
  refine integral_congr_ae (Filter.Eventually.of_forall fun y => ?_)
  simp

theorem fourier_postcompCLM [CompleteSpace F] [CompleteSpace G] (T : F →L[ℂ] G) (f : 𝓢(V, F)) :
    (𝓕 (postcompCLM T f) : 𝓢(V, G)) = postcompCLM T (𝓕 f : 𝓢(V, F)) := by
  ext x
  simpa using fourier_postcompCLM_apply T f x

/-- Postcomposition on Schwartz space is the pointwise action of `T` on `L²`. -/
theorem toLp_postcompCLM (T : F →L[ℂ] G) (f : 𝓢(V, F)) :
    (postcompCLM T f).toLp 2 (volume : Measure V)
      = T.compLp (f.toLp 2 (volume : Measure V)) := by
  refine (MeasureTheory.Lp.ext_iff).2 ?_
  filter_upwards [(postcompCLM T f).coeFn_toLp 2 (volume : Measure V),
    T.coeFn_compLp (f.toLp 2 (volume : Measure V)),
    f.coeFn_toLp 2 (volume : Measure V)] with x hx hTx hfx
  rw [hx, hTx, hfx, postcompCLM_apply]

end Postcomp

/-! ## 2. The partial transform and its fibre-blindness -/

variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

variable (V F) in
/-- **The partial (spatial-only) Fourier transform** of the fibred one-particle space
`L²(V; F)`: Plancherel in the spatial variable `x ∈ V`, with the fibre `F` untouched. -/
def partialFourier : (Lp F 2 (volume : Measure V)) ≃ₗᵢ[ℂ] (Lp F 2 (volume : Measure V)) :=
  MeasureTheory.Lp.fourierTransformₗᵢ V F

@[simp] theorem partialFourier_apply (v : Lp F 2 (volume : Measure V)) :
    partialFourier V F v = 𝓕 v := rfl

/-- Plancherel for the partial transform. -/
theorem partialFourier_norm (v : Lp F 2 (volume : Measure V)) :
    ‖partialFourier V F v‖ = ‖v‖ := (partialFourier V F).norm_map v

/-- The partial transform preserves the inner product. -/
theorem partialFourier_inner (v u : Lp F 2 (volume : Measure V)) :
    (inner ℂ (partialFourier V F v) (partialFourier V F u) : ℂ) = inner ℂ v u :=
  (partialFourier V F).inner_map_map v u

variable (V) in
/-- An operator **of the fibre alone**, acting pointwise in the spatial variable. -/
def fibreOp (T : F →L[ℂ] G) :
    Lp F 2 (volume : Measure V) →L[ℂ] Lp G 2 (volume : Measure V) :=
  T.compLpL 2 (volume : Measure V)

omit [CompleteSpace F] [CompleteSpace G] in
theorem fibreOp_apply (T : F →L[ℂ] G) (f : Lp F 2 (volume : Measure V)) :
    fibreOp V T f = T.compLp f := rfl

/-- **The partial transform leaves the fibre alone.**  It commutes with the pointwise action of
every bounded operator of the fibre: transforming the spatial variable and acting in the fibre are
independent operations. -/
theorem partialFourier_fibreOp (T : F →L[ℂ] G) (f : Lp F 2 (volume : Measure V)) :
    partialFourier V G (fibreOp V T f) = fibreOp V T (partialFourier V F f) := by
  have hcont₁ : Continuous fun f : Lp F 2 (volume : Measure V) =>
      partialFourier V G (fibreOp V T f) :=
    (partialFourier V G).continuous.comp (fibreOp V T).continuous
  have hcont₂ : Continuous fun f : Lp F 2 (volume : Measure V) =>
      fibreOp V T (partialFourier V F f) :=
    (fibreOp V T).continuous.comp (partialFourier V F).continuous
  have hdense : Dense (Set.range (SchwartzMap.toLpCLM ℝ F 2 (volume : Measure V))) :=
    SchwartzMap.denseRange_toLpCLM (F := F) (μ := (volume : Measure V)) ENNReal.ofNat_ne_top
  refine congrFun (Continuous.ext_on hdense hcont₁ hcont₂ ?_) f
  rintro _ ⟨g, rfl⟩
  simp only [SchwartzMap.toLpCLM_apply, partialFourier_apply, fibreOp_apply]
  rw [← toLp_postcompCLM, SchwartzMap.toLp_fourier_eq, SchwartzMap.toLp_fourier_eq,
    ← toLp_postcompCLM, fourier_postcompCLM]

/-! ## 3. The diagonal spatial derivative in the fibred space -/

/-- The spatial momentum operator `π_m = −i ∂_m` on fibre-valued Schwartz functions. -/
def vecMomentumOp (m : V) : 𝓢(V, F) →L[ℂ] 𝓢(V, F) :=
  (-Complex.I) • lineDerivOpCLM ℂ 𝓢(V, F) m

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] [CompleteSpace F] in
@[simp] theorem vecMomentumOp_apply (m : V) (f : 𝓢(V, F)) :
    vecMomentumOp m f = (-Complex.I) • (∂_{m} f : 𝓢(V, F)) := rfl

omit [CompleteSpace F] in
/-- **The diagonal derivative.**  Under the partial transform the spatial momentum `−i ∂_m`
becomes multiplication by the real symbol `2π ⟪ξ, m⟫` — the same symbol as in the scalar case, in
particular independent of the fibre. -/
theorem fourier_vecMomentumOp_apply (m : V) (f : 𝓢(V, F)) (x : V) :
    (𝓕 (vecMomentumOp m f) : 𝓢(V, F)) x
      = ((2 * Real.pi * (inner ℝ x m) : ℝ) : ℂ) • (𝓕 f : 𝓢(V, F)) x := by
  have h : (inner ℝ · m : V → ℝ).HasTemperateGrowth := ((innerSL ℝ).flip m).hasTemperateGrowth
  have hlin : (𝓕 (vecMomentumOp m f) : 𝓢(V, F))
      = (-Complex.I) • (𝓕 (∂_{m} f : 𝓢(V, F)) : 𝓢(V, F)) := by
    change fourierTransformCLM ℂ (vecMomentumOp m f) = _
    simp [vecMomentumOp]
  rw [hlin]
  simp only [SchwartzMap.smul_apply, fourier_lineDerivOp_eq, h, smulLeftCLM_apply,
    Complex.ofReal_mul, Complex.ofReal_ofNat, smul_smul]
  rw [← Complex.coe_smul, smul_smul]
  congr 1
  rw [show (-Complex.I * (2 * (Real.pi : ℂ) * Complex.I)) * ((inner ℝ x m : ℝ) : ℂ)
      = (-(Complex.I * Complex.I)) * (2 * (Real.pi : ℂ) * ((inner ℝ x m : ℝ) : ℂ)) by ring,
    show Complex.I * Complex.I = -1 from Complex.I_mul_I]
  ring

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] [CompleteSpace F]
  [CompleteSpace G] in
/-- The spatial momentum commutes with every operator of the fibre. -/
theorem postcompCLM_vecMomentumOp (T : F →L[ℂ] G) (m : V) (f : 𝓢(V, F)) :
    postcompCLM T (vecMomentumOp m f) = vecMomentumOp m (postcompCLM T f) := by
  calc postcompCLM T (vecMomentumOp m f)
      = (-Complex.I) • postcompCLM T (∂_{m} f : 𝓢(V, F)) := by
        rw [vecMomentumOp_apply, map_smul]
    _ = vecMomentumOp m (postcompCLM T f) := by
        rw [postcompCLM_lineDerivOp, vecMomentumOp_apply]

/-! ## 4. The Navier–Stokes instance: the fibre is an `L²` space -/

section Concrete

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [FiniteDimensional ℝ W]
  [MeasurableSpace W] [BorelSpace W]

variable (V W) in
/-- **The spatial-only Fourier transform of the fibred Navier–Stokes one-particle space.**  The
space is `L²(V; L²(W))` — square-integrable functions of the spatial variable `x ∈ V` with values
in the fibre space `L²(W)` of the fibre variable `u ∈ W` — and the transform acts in `x` only. -/
def nsPartialFourier :
    (Lp (Lp ℂ 2 (volume : Measure W)) 2 (volume : Measure V)) ≃ₗᵢ[ℂ]
      (Lp (Lp ℂ 2 (volume : Measure W)) 2 (volume : Measure V)) :=
  partialFourier V (Lp ℂ 2 (volume : Measure W))

/-- Plancherel for the spatial-only transform. -/
theorem nsPartialFourier_norm (v : Lp (Lp ℂ 2 (volume : Measure W)) 2 (volume : Measure V)) :
    ‖nsPartialFourier V W v‖ = ‖v‖ := (nsPartialFourier V W).norm_map v

/-- **The spatial transform does not touch the fibre variable**: it commutes with every bounded
operator acting in the fibre variable `u ∈ W`. -/
theorem nsPartialFourier_fibreOp (T : Lp ℂ 2 (volume : Measure W) →L[ℂ] Lp ℂ 2 (volume : Measure W))
    (f : Lp (Lp ℂ 2 (volume : Measure W)) 2 (volume : Measure V)) :
    nsPartialFourier V W (fibreOp V T f) = fibreOp V T (nsPartialFourier V W f) :=
  partialFourier_fibreOp T f

variable (W) in
/-- The Fourier transform **of the fibre variable**, as an operator of the fibre. -/
def fibreFourierCLM : Lp ℂ 2 (volume : Measure W) →L[ℂ] Lp ℂ 2 (volume : Measure W) :=
  (MeasureTheory.Lp.fourierTransformₗᵢ W ℂ).toLinearIsometry.toContinuousLinearMap



/-- The two partial transforms commute as operators. -/
theorem nsPartialFourier_comp_fibreFourier_eq :
    ((nsPartialFourier V W).toLinearIsometry.toContinuousLinearMap).comp
        (fibreOp V (fibreFourierCLM W))
      = (fibreOp V (fibreFourierCLM W)).comp
        ((nsPartialFourier V W).toLinearIsometry.toContinuousLinearMap) :=
  ContinuousLinearMap.ext fun f => nsPartialFourier_fibreFourier f

end Concrete

end

end BookProof.NsPartialFourier
