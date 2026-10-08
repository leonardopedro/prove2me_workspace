import Definitions.Def_ChapterFourierMultiplierEsa
import Definitions.Def_ChapterStrichartzWave
import Mathlib


/-!
# The Plancherel identification and the diagonal spatial derivative

Part of item 1 of the Navier–Stokes plan items of `CONSOLIDATED_PLAN.md`: *the spatial Fourier
unitary and the diagonal derivative*.  The item asks for the Plancherel identification of the
one-particle space and for the statement that on it the spatial derivative `−i ∂_{x_j}` is the
Fourier multiplier of the real symbol `p_j`.

What is proved here, for an arbitrary finite-dimensional real inner-product space `V` carrying the
volume measure:

* `l2Fourier` — the Plancherel identification of `L²(V)` with itself in the momentum variable, as a
  linear isometry equivalence (Mathlib's `MeasureTheory.Lp.fourierTransformₗᵢ`), with
  `l2Fourier_norm` and `l2Fourier_inner` the unitarity statements;
* `fourier_opL2_eq_mulSymbol` — **the multiplier statement at the `L²` level**: if the Fourier
  transform turns a Schwartz operator `P` into multiplication by the real symbol `σ`, then on the
  Schwartz core the Plancherel identification carries the `L²` realization of `P` to multiplication
  by `σ`.  This upgrades the pointwise Schwartz-space identity of
  `BookProof.FourierMultiplierEsa` to the Hilbert space where the operator lives;
* `fourier_opL2_firstOrderOp` and `fourier_opL2_momentumOp` — the specialization to the momentum
  operators: `∑_j c_j (−i ∂_{w_j})` becomes multiplication by `∑_j 2π c_j ⟪ξ, w_j⟫`, and `−i ∂_m`
  becomes multiplication by `2π ⟪ξ, m⟫` — the real symbol `p_j` of the plan item;
* `foSymbolFn_add_fibre` and `foSymbolFn_congr_of_inner_eq` — **the derivative is diagonal in the
  spatial momentum and blind to the fibre**: the symbol of a family of *spatial* directions is
  unchanged when the frequency is moved by any vector orthogonal to all of them, so it depends on
  the spatial frequency only;
* `spatialMomentum_esa` — essential self-adjointness of the spatial momentum family on the
  Schwartz core (`BookProof.FourierMultiplierEsa.firstOrderOp_essentiallySelfAdjoint`), so the
  derivative side of the construction is a proved instrument.

**Honest boundary.**  The identification used is the *full* Plancherel transform of `L²(V)`; the
partial ("spatial-only") transform `L²(ℝ_x^d × ℝ_u^m) ≅ L²(ℝ_p^d × ℝ_u^m)`, which transforms the
spatial variable and leaves the fibre variable alone, is **not** constructed here.  What is proved
instead is that the symbol of a spatial derivative does not see the fibre frequency
(`foSymbolFn_add_fibre`), which is the content the route uses: the spatial derivative is diagonal
in the spatial momentum and acts as the identity on the fibre.  The remaining part of plan item 1
is therefore the construction of the partial transform itself.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.NsSpatialMultiplier

open MeasureTheory SchwartzMap FourierTransform
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa

noncomputable section

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

/-! ## 1. The Plancherel identification -/

variable (V) in
/-- **The Plancherel identification** of `L²(V)` with the momentum-side `L²(V)`: the Fourier
transform as a linear isometry equivalence. -/
def l2Fourier : (Lp ℂ 2 (volume : Measure V)) ≃ₗᵢ[ℂ] (Lp ℂ 2 (volume : Measure V)) :=
  MeasureTheory.Lp.fourierTransformₗᵢ V ℂ

@[simp] theorem l2Fourier_apply (v : Lp ℂ 2 (volume : Measure V)) :
    l2Fourier V v = 𝓕 v := rfl





/-! ## 2. Multiplication by a real symbol, and the multiplier statement on `L²` -/

/-- Multiplication by a real symbol, on Schwartz space. -/
def mulSymbolOp (σ : V → ℝ) : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ) :=
  smulLeftCLM ℂ (fun x => ((σ x : ℝ) : ℂ))





/-! ## 3. The symbol of the momentum operators, as a continuous linear functional -/

/-- The symbol `ξ ↦ ∑_j 2π c_j ⟪ξ, w_j⟫` of `∑_j c_j (−i ∂_{w_j})`, as a continuous linear
functional — which is what makes it a function of temperate growth. -/
def foSymbolCLM (c : ι → ℝ) (w : ι → V) : V →L[ℝ] ℝ :=
  ∑ i, (2 * Real.pi * c i) • ((innerSL ℝ).flip (w i))





/-! ## 4. The momentum operator is multiplication by the momentum -/





/-! ## 5. The spatial symbol is blind to the fibre -/





/-! ## 6. The concrete picture `ℝ_x^d × ℝ_u^m` -/

ED_PLAN.md`: *the spatial Fourier
unitary and the diagonal derivative*.  The item asks for the Plancherel identification of the
one-particle space and for the statement that on it the spatial derivative `−i ∂_{x_j}` is the
Fourier multiplier of the real symbol `p_j`.

What is proved here, for an arbitrary finite-dimensional real inner-product space `V` carrying the
volume measure:

* `l2Fourier` — the Plancherel identification of `L²(V)` with itself in the momentum variable, as a
  linear isometry equivalence (Mathlib's `MeasureTheory.Lp.fourierTransformₗᵢ`), with
  `l2Fourier_norm` and `l2Fourier_inner` the unitarity statements;
* `fourier_opL2_eq_mulSymbol` — **the multiplier statement at the `L²` level**: if the Fourier
  transform turns a Schwartz operator `P` into multiplication by the real symbol `σ`, then on the
  Schwartz core the Plancherel identification carries the `L²` realization of `P` to multiplication
  by `σ`.  This upgrades the pointwise Schwartz-space identity of
  `BookProof.FourierMultiplierEsa` to the Hilbert space where the operator lives;
* `fourier_opL2_firstOrderOp` and `fourier_opL2_momentumOp` — the specialization to the momentum
  operators: `∑_j c_j (−i ∂_{w_j})` becomes multiplication by `∑_j 2π c_j ⟪ξ, w_j⟫`, and `−i ∂_m`
  becomes multiplication by `2π ⟪ξ, m⟫` — the real symbol `p_j` of the plan item;
* `foSymbolFn_add_fibre` and `foSymbolFn_congr_of_inner_eq` — **the derivative is diagonal in the
  spatial momentum and blind to the fibre**: the symbol of a family of *spatial* directions is
  unchanged when the frequency is moved by any vector orthogonal to all of them, so it depends on
  the spatial frequency only;
* `spatialMomentum_esa` — essential self-adjointness of the spatial momentum family on the
  Schwartz core (`BookProof.FourierMultiplierEsa.firstOrderOp_essentiallySelfAdjoint`), so the
  derivative side of the construction is a proved instrument.

**Honest boundary.**  The identification used is the *full* Plancherel transform of `L²(V)`; the
partial ("spatial-only") transform `L²(ℝ_x^d × ℝ_u^m) ≅ L²(ℝ_p^d × ℝ_u^m)`, which transforms the
spatial variable and leaves the fibre variable alone, is **not** constructed here.  What is proved
instead is that the symbol of a spatial derivative does not see the fibre frequency
(`foSymbolFn_add_fibre`), which is the content the route uses: the spatial derivative is diagonal
in the spatial momentum and acts as the identity on the fibre.  The remaining part of plan item 1
is therefore the construction of the partial transform itself.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.NsSpatialMultiplier

open MeasureTheory SchwartzMap FourierTransform
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa

noncomputable section

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

/-! ## 1. The Plancherel identification -/

variable (V) in
/-- **The Plancherel identification** of `L²(V)` with the momentum-side `L²(V)`: the Fourier
transform as a linear isometry equivalence. -/
def l2Fourier : (Lp ℂ 2 (volume : Measure V)) ≃ₗᵢ[ℂ] (Lp ℂ 2 (volume : Measure V)) :=
  MeasureTheory.Lp.fourierTransformₗᵢ V ℂ

@[simp] theorem l2Fourier_apply (v : Lp ℂ 2 (volume : Measure V)) :
    l2Fourier V v = 𝓕 v := rfl

/-- Plancherel: the identification is norm preserving. -/
theorem l2Fourier_norm (v : Lp ℂ 2 (volume : Measure V)) : ‖l2Fourier V v‖ = ‖v‖ :=
  (l2Fourier V).norm_map v

/-- Plancherel: the identification preserves the inner product. -/
theorem l2Fourier_inner (v u : Lp ℂ 2 (volume : Measure V)) :
    (inner ℂ (l2Fourier V v) (l2Fourier V u) : ℂ) = inner ℂ v u :=
  (l2Fourier V).inner_map_map v u

/-! ## 2. Multiplication by a real symbol, and the multiplier statement on `L²` -/

/-- Multiplication by a real symbol, on Schwartz space. -/
def mulSymbolOp (σ : V → ℝ) : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ) :=
  smulLeftCLM ℂ (fun x => ((σ x : ℝ) : ℂ))

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
theorem mulSymbolOp_apply (σ : V → ℝ)
    (hσ : Function.HasTemperateGrowth (fun x : V => ((σ x : ℝ) : ℂ)))
    (f : 𝓢(V, ℂ)) (x : V) :
    (mulSymbolOp σ f : 𝓢(V, ℂ)) x = ((σ x : ℝ) : ℂ) * f x := by
  simp [mulSymbolOp, smulLeftCLM_apply hσ]

/-- **The multiplier statement on the Hilbert space.**  If the Fourier transform turns the
Schwartz operator `P` into multiplication by the real symbol `σ`, then the Plancherel
identification carries the `L²` realization of `P`, on a Schwartz vector, to the `L²` vector of the
multiplication of `𝓕 f` by `σ`.  In particular `P` is unitarily equivalent, on the Schwartz core,
to multiplication by its symbol. -/
theorem fourier_opL2_eq_mulSymbol (P : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ)) (σ : V → ℝ)
    (hP : ∀ (f : 𝓢(V, ℂ)) (x : V),
      (𝓕 (P f) : 𝓢(V, ℂ)) x = ((σ x : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x)
    (hσ : Function.HasTemperateGrowth (fun x : V => ((σ x : ℝ) : ℂ)))
    (f : 𝓢(V, ℂ)) :
    l2Fourier V (opL2 P (schwartzEquiv V f))
      = (mulSymbolOp σ (𝓕 f)).toLp 2 (volume : Measure V) := by
  rw [l2Fourier_apply, opL2_apply, SchwartzMap.toLp_fourier_eq]
  congr 1
  ext x
  rw [hP, mulSymbolOp_apply σ hσ]

/-! ## 3. The symbol of the momentum operators, as a continuous linear functional -/

/-- The symbol `ξ ↦ ∑_j 2π c_j ⟪ξ, w_j⟫` of `∑_j c_j (−i ∂_{w_j})`, as a continuous linear
functional — which is what makes it a function of temperate growth. -/
def foSymbolCLM (c : ι → ℝ) (w : ι → V) : V →L[ℝ] ℝ :=
  ∑ i, (2 * Real.pi * c i) • ((innerSL ℝ).flip (w i))

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
theorem foSymbolCLM_apply (c : ι → ℝ) (w : ι → V) (x : V) :
    foSymbolCLM c w x = foSymbolFn c w x := by
  simp only [foSymbolCLM, ContinuousLinearMap.coe_sum', Finset.sum_apply,
    ContinuousLinearMap.coe_smul', Pi.smul_apply, ContinuousLinearMap.flip_apply,
    innerSL_apply_apply, smul_eq_mul, foSymbolFn, mul_assoc]

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
theorem hasTemperateGrowth_foSymbol (c : ι → ℝ) (w : ι → V) :
    Function.HasTemperateGrowth (fun x : V => ((foSymbolFn c w x : ℝ) : ℂ)) := by
  have h : (fun x : V => ((foSymbolFn c w x : ℝ) : ℂ))
      = fun x => (Complex.ofRealCLM.comp (foSymbolCLM c w)) x := by
    funext x
    simp [foSymbolCLM_apply]
  rw [h]
  exact ContinuousLinearMap.hasTemperateGrowth _

/-! ## 4. The momentum operator is multiplication by the momentum -/

/-- **The diagonal derivative.**  Under the Plancherel identification, the first-order operator
`∑_j c_j (−i ∂_{w_j})` acts on the Schwartz core as multiplication by the real symbol
`∑_j 2π c_j ⟪ξ, w_j⟫`. -/
theorem fourier_opL2_firstOrderOp (c : ι → ℝ) (w : ι → V) (f : 𝓢(V, ℂ)) :
    l2Fourier V (opL2 (firstOrderOp c w) (schwartzEquiv V f))
      = (mulSymbolOp (foSymbolFn c w) (𝓕 f)).toLp 2 (volume : Measure V) :=
  fourier_opL2_eq_mulSymbol _ _ (fourier_firstOrderOp_apply c w)
    (hasTemperateGrowth_foSymbol c w) f

/-- The one-direction case: `−i ∂_m` is multiplication by `2π ⟪ξ, m⟫` — the real symbol `p_j` of
plan item 1. -/
theorem fourier_opL2_momentumOp (m : V) (f : 𝓢(V, ℂ)) :
    l2Fourier V (opL2 (momentumOp m) (schwartzEquiv V f))
      = (mulSymbolOp (fun x => 2 * Real.pi * (inner ℝ x m : ℝ)) (𝓕 f)).toLp
          2 (volume : Measure V) := by
  have hσ : Function.HasTemperateGrowth
      (fun x : V => ((2 * Real.pi * (inner ℝ x m : ℝ) : ℝ) : ℂ)) := by
    have h := hasTemperateGrowth_foSymbol (fun _ : Fin 1 => (1 : ℝ)) (fun _ => m)
    simpa [foSymbolFn] using h
  refine fourier_opL2_eq_mulSymbol _ _ ?_ hσ f
  intro g x
  simpa using fourier_momentumOp_apply g m x

/-! ## 5. The spatial symbol is blind to the fibre -/

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
/-- **The symbol only sees the spatial frequency.**  Two frequencies with the same pairings against
the directions `w` give the same symbol. -/
theorem foSymbolFn_congr_of_inner_eq (c : ι → ℝ) (w : ι → V) {x y : V}
    (h : ∀ i, (inner ℝ x (w i) : ℝ) = inner ℝ y (w i)) :
    foSymbolFn c w x = foSymbolFn c w y :=
  Finset.sum_congr rfl fun i _ => by rw [h i]

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
/-- **The fibre momentum is untouched.**  Moving the frequency by a vector orthogonal to every
spatial direction does not change the symbol of the spatial derivative: on the momentum side the
operator is diagonal in the spatial frequency and acts as the identity in the fibre frequency. -/
theorem foSymbolFn_add_fibre (c : ι → ℝ) (w : ι → V) (x m : V)
    (hm : ∀ i, (inner ℝ m (w i) : ℝ) = 0) (t : ℝ) :
    foSymbolFn c w (x + t • m) = foSymbolFn c w x := by
  refine foSymbolFn_congr_of_inner_eq c w fun i => ?_
  rw [inner_add_left, real_inner_smul_left, hm i, mul_zero, add_zero]

/-! ## 6. The concrete picture `ℝ_x^d × ℝ_u^m` -/

/-- **Non-vacuity, in the concrete picture of the route.**  On `ℝ^n`, split into the spatial
coordinates `s i` and a fibre coordinate `j` distinct from all of them, the symbol of the spatial
momentum family does not change when the frequency is moved in the fibre direction: the spatial
derivative is diagonal in the spatial momentum and blind to the fibre momentum. -/
theorem euclidean_foSymbolFn_add_fibre {n : ℕ} (c : ι → ℝ) (s : ι → Fin n) (j : Fin n)
    (hj : ∀ i, s i ≠ j) (x : EuclideanSpace ℝ (Fin n)) (t : ℝ) :
    foSymbolFn c (fun i => EuclideanSpace.single (s i) (1 : ℝ))
        (x + t • EuclideanSpace.single j (1 : ℝ))
      = foSymbolFn c (fun i => EuclideanSpace.single (s i) (1 : ℝ)) x := by
  refine foSymbolFn_add_fibre c _ x _ (fun i => ?_) t
  have h : j ≠ s i := fun hh => hj i hh.symm
  simp [EuclideanSpace.inner_single_left, EuclideanSpace.single_apply, h]

/-! ## 7. Essential self-adjointness of the spatial momentum family -/

/-- **The spatial momentum family is essentially self-adjoint** on the Schwartz core of `L²(V)`:
the derivative side of the construction is a proved instrument, not new analysis. -/
theorem spatialMomentum_esa (c : ι → ℝ) (w : ι → V) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain V)
      (opL2 (firstOrderOp c w)) :=
  firstOrderOp_essentiallySelfAdjoint c w

end

end BookProof.NsSpatialMultiplier
