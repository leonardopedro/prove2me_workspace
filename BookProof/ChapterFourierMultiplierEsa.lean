import Mathlib
import BookProof.ChapterStrichartzWave

/-!
# Essential self-adjointness of Fourier multipliers with a real symbol

`BookProof.ChapterStrichartzWave` proves that the *second-order* constant-coefficient
operator `∑ᵢ cᵢ ∂_{wᵢ}² + κ` is essentially self-adjoint on the Schwartz core of `L²(V)`,
by the Fourier-multiplier route: under Plancherel the operator becomes multiplication by
its real symbol, symmetry is immediate, and the deficiency equation is killed by dividing
a test function by `symbol − z̄`.

That argument never uses the *shape* of the operator: it uses only that the operator is a
Fourier multiplier with a **real, smooth** symbol.  This module extracts it as a reusable
instrument and applies it to the operators the second-order family could not reach — the
*first-order* ones.

## What is proved

* `symmetricOn_of_real_symbol`, `deficiencyTrivialAt_of_real_symbol`,
  `essentiallySelfAdjointOn_of_real_symbol` — **the instrument**: any continuous linear
  operator `P` on Schwartz space which the Fourier transform turns into multiplication by
  a real, smooth function `σ` is symmetric and essentially self-adjoint on the Schwartz
  core of `L²(V)`;
* `foSymbolFn`, `fourier_firstOrderOp_apply` — the first-order operator
  `∑ᵢ cᵢ πᵢ`, `πᵢ = −i ∂_{wᵢ}`, is the Fourier multiplier with the real symbol
  `∑ᵢ 2π cᵢ ⟪ξ, wᵢ⟫`;
* `firstOrderOp_essentiallySelfAdjoint` — **the momentum operator is essentially
  self-adjoint** on the Schwartz core, for an arbitrary finite family of directions and
  arbitrary real coefficients; `momentumOp_essentiallySelfAdjoint` is the one-direction
  case `−i ∂_m`;
* `mixedOp_essentiallySelfAdjoint` — the full real-symbol constant-coefficient operator
  `∑ᵢ cᵢ ∂_{wᵢ}² + ∑ᵢ aᵢ (−i ∂_{wᵢ}) + κ`, second order plus first order plus a constant,
  is essentially self-adjoint on the same core.

The last statement covers the *kernel directions* of the quadratic family of
`BookProof.ChapterShiftedQuadraticDegenerate`, in the case where only the momentum
coefficient survives: there `H` degenerates to `∑ᵢ b'ᵢ πᵢ`, which has no `L²` eigenvector,
so the Hermite-eigenbasis argument used for the quadratic family cannot see it, while the
Fourier multiplier argument here handles it directly.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.FourierMultiplierEsa

open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

/-! ## 1. The instrument: a real symbol gives essential self-adjointness -/

/-- **Symmetry from a real symbol.**  If the Fourier transform turns `P` into
multiplication by the real function `σ`, then `P` is symmetric on the Schwartz core. -/
theorem symmetricOn_of_real_symbol (P : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ)) (σ : V → ℝ)
    (hP : ∀ (f : 𝓢(V, ℂ)) (x : V),
      (𝓕 (P f) : 𝓢(V, ℂ)) x = ((σ x : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x) :
    BookProof.FarisLavine.SymmetricOn (schwartzDomain V) (opL2 P) := by
  intro x y
  obtain ⟨f, rfl⟩ := (schwartzEquiv V).surjective x
  obtain ⟨g, rfl⟩ := (schwartzEquiv V).surjective y
  rw [opL2_apply, opL2_apply, schwartzEquiv_coe, schwartzEquiv_coe,
    inner_toLp_eq_integral_fourier, inner_toLp_eq_integral_fourier]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only [hP, map_mul, Complex.conj_ofReal]
  ring

/-- The key identity for the deficiency equation: testing against `𝓕⁻¹ ψ` gives
`∫ conj ψ · (σ − z) · 𝓕 u = 0`. -/
theorem integral_conj_mul_symbol_sub_eq_zero' (P : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ)) (σ : V → ℝ)
    (hP : ∀ (f : 𝓢(V, ℂ)) (x : V),
      (𝓕 (P f) : 𝓢(V, ℂ)) x = ((σ x : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x)
    (z : ℂ) (u : Lp ℂ 2 (volume : Measure V))
    (hu : ∀ v : schwartzDomain V,
      (inner ℂ (opL2 P v) u : ℂ) = z * inner ℂ (v : Lp ℂ 2 _) u)
    (ψ : 𝓢(V, ℂ)) :
    ∫ x, (starRingEnd ℂ) (ψ x) * (((σ x : ℝ) : ℂ) - z) *
      ((𝓕 u : Lp ℂ 2 (volume : Measure V)) x) = 0 := by
  set g : Lp ℂ 2 (volume : Measure V) := 𝓕 u with hg
  set f : 𝓢(V, ℂ) := 𝓕⁻ ψ with hfdef
  have hf : (𝓕 f : 𝓢(V, ℂ)) = ψ := fourier_fourierInv_eq ψ
  have h1 := hu (schwartzEquiv V f)
  rw [opL2_apply, schwartzEquiv_coe, inner_toLp_left_fourier, inner_toLp_left_fourier] at h1
  have hL : ∫ x, (starRingEnd ℂ) ((𝓕 (P f) : 𝓢(V, ℂ)) x) * (g x)
      = ∫ x, ((σ x : ℝ) : ℂ) * ((starRingEnd ℂ) (ψ x) * (g x)) := by
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only [hP, hf, map_mul, Complex.conj_ofReal]
    ring
  rw [hL, hf] at h1
  have hint1 : Integrable (fun x => (starRingEnd ℂ) (ψ x) * (g x)) (volume : Measure V) :=
    integrable_conj_schwartz_mul ψ g
  have hint2 : Integrable
      (fun x => ((σ x : ℝ) : ℂ) * ((starRingEnd ℂ) (ψ x) * (g x))) (volume : Measure V) := by
    have := integrable_conj_schwartz_mul (𝓕 (P f) : 𝓢(V, ℂ)) g
    refine this.congr (Filter.Eventually.of_forall fun x => ?_)
    simp only [hP, hf, map_mul, Complex.conj_ofReal]
    ring
  have hcomb : ∫ x, (((σ x : ℝ) : ℂ) * ((starRingEnd ℂ) (ψ x) * (g x))
      - z * ((starRingEnd ℂ) (ψ x) * (g x))) = 0 := by
    rw [integral_sub hint2 (hint1.const_mul z), MeasureTheory.integral_const_mul, h1]
    ring
  rw [← hcomb]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  ring

/-- **Vanishing deficiency spaces from a real symbol.** -/
theorem deficiencyTrivialAt_of_real_symbol (P : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ)) (σ : V → ℝ)
    (hP : ∀ (f : 𝓢(V, ℂ)) (x : V),
      (𝓕 (P f) : 𝓢(V, ℂ)) x = ((σ x : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x)
    (hσ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) σ) {z : ℂ} (hz : z.im ≠ 0) :
    BookProof.FarisLavine.DeficiencyTrivialAt (schwartzDomain V) (opL2 P) z := by
  intro u hu
  have hz1 : ∀ x : V, ((σ x : ℝ) : ℂ) - (starRingEnd ℂ) z ≠ 0 := by
    intro x hx
    exact hz (by simpa using congrArg Complex.im hx)
  have hz2 : ∀ x : V, ((σ x : ℝ) : ℂ) - z ≠ 0 := by
    intro x hx
    exact hz (by simpa using congrArg Complex.im hx)
  have main : ∀ χ : V → ℝ, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) χ → HasCompactSupport χ →
      ∫ x, χ x • ((𝓕 u : Lp ℂ 2 (volume : Measure V)) x) = 0 := by
    intro χ hχ hχc
    have hsmooth : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞)
        (fun x => (χ x : ℂ) * (((σ x : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹) := by
      refine (Complex.ofRealCLM.contDiff.comp hχ).mul (ContDiff.inv ?_ hz1)
      exact (Complex.ofRealCLM.contDiff.comp hσ).sub contDiff_const
    have hsupp : HasCompactSupport
        (fun x => (χ x : ℂ) * (((σ x : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹) := by
      refine HasCompactSupport.mul_right ?_
      simpa using hχc.comp_left (g := fun r : ℝ => (r : ℂ)) (by simp)
    obtain ⟨ψ, hψcoe⟩ : ∃ ψ : 𝓢(V, ℂ), (ψ : V → ℂ) =
        fun x => (χ x : ℂ) * (((σ x : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹ :=
      ⟨hsupp.toSchwartzMap hsmooth, rfl⟩
    have key := integral_conj_mul_symbol_sub_eq_zero' P σ hP z u hu ψ
    rw [← key]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    have hpx : ψ x = (χ x : ℂ) * (((σ x : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹ :=
      congrFun hψcoe x
    have hc : (starRingEnd ℂ) (ψ x) * (((σ x : ℝ) : ℂ) - z) = (χ x : ℂ) := by
      rw [hpx]
      simp only [map_mul, map_inv₀, map_sub, Complex.conj_ofReal, Complex.conj_conj]
      field_simp
      exact mul_div_cancel_right₀ _ (hz2 x)
    change χ x • ((𝓕 u : Lp ℂ 2 (volume : Measure V)) x)
      = (starRingEnd ℂ) (ψ x) * (((σ x : ℝ) : ℂ) - z) *
        ((𝓕 u : Lp ℂ 2 (volume : Measure V)) x)
    rw [Complex.real_smul, ← hc]
  have hgloc : LocallyIntegrable
      (fun x => ((𝓕 u : Lp ℂ 2 (volume : Measure V)) x : ℂ)) (volume : Measure V) :=
    (Lp.memLp (𝓕 u : Lp ℂ 2 (volume : Measure V))).locallyIntegrable (by norm_num)
  have hae : ∀ᵐ x ∂(volume : Measure V), ((𝓕 u : Lp ℂ 2 (volume : Measure V)) x : ℂ) = 0 :=
    ae_eq_zero_of_integral_contDiff_smul_eq_zero hgloc (fun χ hχ hχc => main χ hχ hχc)
  have hg0 : (𝓕 u : Lp ℂ 2 (volume : Measure V)) = 0 := Lp.eq_zero_iff_ae_eq_zero.mpr hae
  have hnorm : ‖u‖ = 0 := by
    rw [← MeasureTheory.Lp.norm_fourier_eq u, hg0, norm_zero]
  exact norm_eq_zero.mp hnorm

/-- **The instrument.**  A Fourier multiplier with a real, smooth symbol is essentially
self-adjoint on the Schwartz core of `L²(V)`. -/
theorem essentiallySelfAdjointOn_of_real_symbol (P : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ)) (σ : V → ℝ)
    (hP : ∀ (f : 𝓢(V, ℂ)) (x : V),
      (𝓕 (P f) : 𝓢(V, ℂ)) x = ((σ x : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x)
    (hσ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) σ) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain V) (opL2 P) :=
  ⟨deficiencyTrivialAt_of_real_symbol P σ hP hσ (by simp),
    deficiencyTrivialAt_of_real_symbol P σ hP hσ (by simp)⟩

/-! ## 2. The first-order (momentum) operator -/

/-- The momentum operator `π_m = −i ∂_m` on Schwartz space. -/
noncomputable def momentumOp (m : V) : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ) :=
  (-Complex.I) • lineDerivOpCLM ℂ 𝓢(V, ℂ) m

/-- The general first-order operator `∑ᵢ cᵢ π_{wᵢ}` with real coefficients. -/
noncomputable def firstOrderOp (c : ι → ℝ) (w : ι → V) : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ) :=
  ∑ i, (c i : ℂ) • momentumOp (w i)

/-- The (real!) symbol of `firstOrderOp c w`: `∑ᵢ 2π cᵢ ⟪ξ, wᵢ⟫`. -/
noncomputable def foSymbolFn (c : ι → ℝ) (w : ι → V) (x : V) : ℝ :=
  ∑ i, 2 * Real.pi * c i * (inner ℝ x (w i))

lemma fourier_momentumOp_apply (f : 𝓢(V, ℂ)) (m : V) (x : V) :
    (𝓕 (momentumOp m f) : 𝓢(V, ℂ)) x
      = ((2 * Real.pi * (inner ℝ x m) : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x := by
  have h : (inner ℝ · m : V → ℝ).HasTemperateGrowth := ((innerSL ℝ).flip m).hasTemperateGrowth
  have hlin : (𝓕 (momentumOp m f) : 𝓢(V, ℂ))
      = (-Complex.I) • (𝓕 (∂_{m} f : 𝓢(V, ℂ)) : 𝓢(V, ℂ)) := by
    change fourierTransformCLM ℂ (momentumOp m f) = _
    simp [momentumOp]
  rw [hlin]
  simp only [SchwartzMap.smul_apply, smul_eq_mul, fourier_lineDerivOp_eq, h, smulLeftCLM_apply,
    Complex.real_smul, Complex.ofReal_mul, Complex.ofReal_ofNat]
  rw [show (-Complex.I) * (((2 : ℂ) * Real.pi * Complex.I) *
      (((inner ℝ x m : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x))
      = (-(Complex.I * Complex.I)) * ((2 : ℂ) * Real.pi * ((inner ℝ x m : ℝ) : ℂ) *
        (𝓕 f : 𝓢(V, ℂ)) x) by ring]
  rw [show Complex.I * Complex.I = -1 from Complex.I_mul_I]
  ring

lemma fourier_firstOrderOp_apply (c : ι → ℝ) (w : ι → V) (f : 𝓢(V, ℂ)) (x : V) :
    (𝓕 (firstOrderOp c w f) : 𝓢(V, ℂ)) x
      = ((foSymbolFn c w x : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x := by
  have hlin : (𝓕 (firstOrderOp c w f) : 𝓢(V, ℂ))
      = ∑ i, (c i : ℂ) • (𝓕 (momentumOp (w i) f) : 𝓢(V, ℂ)) := by
    change fourierTransformCLM ℂ (firstOrderOp c w f) = _
    simp [firstOrderOp]
  rw [hlin]
  simp only [SchwartzMap.sum_apply, SchwartzMap.smul_apply, smul_eq_mul,
    fourier_momentumOp_apply, foSymbolFn, Complex.ofReal_sum, Complex.ofReal_mul,
    Complex.ofReal_ofNat, Finset.sum_mul]
  exact Finset.sum_congr rfl fun i _ => by ring

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
lemma contDiff_foSymbolFn (c : ι → ℝ) (w : ι → V) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (foSymbolFn c w) := by
  unfold foSymbolFn
  exact ContDiff.sum fun i _ => contDiff_const.mul (((innerSL ℝ).flip (w i)).contDiff)

/-- The first-order operator is symmetric on the Schwartz core. -/
theorem firstOrderOp_symmetric (c : ι → ℝ) (w : ι → V) :
    BookProof.FarisLavine.SymmetricOn (schwartzDomain V) (opL2 (firstOrderOp c w)) :=
  symmetricOn_of_real_symbol _ _ (fourier_firstOrderOp_apply c w)

/-- **The momentum operator family is essentially self-adjoint.**  For an arbitrary finite
family of directions `w` and arbitrary real coefficients `c`, the first-order operator
`∑ᵢ cᵢ (−i ∂_{wᵢ})` is essentially self-adjoint on the Schwartz core of `L²(V)`. -/
theorem firstOrderOp_essentiallySelfAdjoint (c : ι → ℝ) (w : ι → V) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain V)
      (opL2 (firstOrderOp c w)) :=
  essentiallySelfAdjointOn_of_real_symbol _ _ (fourier_firstOrderOp_apply c w)
    (contDiff_foSymbolFn c w)

/-- The one-direction case: `π_m = −i ∂_m` is essentially self-adjoint on the Schwartz
core. -/
theorem momentumOp_essentiallySelfAdjoint (m : V) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain V)
      (opL2 (momentumOp m)) := by
  have h : momentumOp m = firstOrderOp (fun _ : Fin 1 => (1 : ℝ)) (fun _ => m) := by
    simp [firstOrderOp]
  rw [h]
  exact firstOrderOp_essentiallySelfAdjoint _ _

/-! ## 3. Second order plus first order plus a constant -/

/-- The full constant-coefficient operator `∑ᵢ cᵢ ∂_{wᵢ}² + ∑ᵢ aᵢ (−i ∂_{wᵢ}) + κ`. -/
noncomputable def mixedOp (a c : ι → ℝ) (w : ι → V) (κ : ℝ) : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ) :=
  constCoeffOp c w κ + firstOrderOp a w

/-- Its (real) symbol. -/
noncomputable def mixedSymbolFn (a c : ι → ℝ) (w : ι → V) (κ : ℝ) (x : V) : ℝ :=
  symbolFn c w κ x + foSymbolFn a w x

lemma fourier_mixedOp_apply (a c : ι → ℝ) (w : ι → V) (κ : ℝ) (f : 𝓢(V, ℂ)) (x : V) :
    (𝓕 (mixedOp a c w κ f) : 𝓢(V, ℂ)) x
      = ((mixedSymbolFn a c w κ x : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x := by
  have hlin : (𝓕 (mixedOp a c w κ f) : 𝓢(V, ℂ))
      = (𝓕 (constCoeffOp c w κ f) : 𝓢(V, ℂ)) + (𝓕 (firstOrderOp a w f) : 𝓢(V, ℂ)) := by
    change fourierTransformCLM ℂ (mixedOp a c w κ f) = _
    simp [mixedOp]
  rw [hlin]
  simp only [SchwartzMap.add_apply, fourier_constCoeffOp_apply, fourier_firstOrderOp_apply,
    mixedSymbolFn, Complex.ofReal_add]
  ring

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
lemma contDiff_mixedSymbolFn (a c : ι → ℝ) (w : ι → V) (κ : ℝ) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (mixedSymbolFn a c w κ) :=
  (contDiff_symbolFn c w κ).add (contDiff_foSymbolFn a w)

/-- The mixed operator is symmetric on the Schwartz core. -/
theorem mixedOp_symmetric (a c : ι → ℝ) (w : ι → V) (κ : ℝ) :
    BookProof.FarisLavine.SymmetricOn (schwartzDomain V) (opL2 (mixedOp a c w κ)) :=
  symmetricOn_of_real_symbol _ _ (fourier_mixedOp_apply a c w κ)

/-- **The headline.**  The general real-symbol constant-coefficient operator
`∑ᵢ cᵢ ∂_{wᵢ}² + ∑ᵢ aᵢ (−i ∂_{wᵢ}) + κ` — second order, plus an unbounded first-order
term, plus a constant — is essentially self-adjoint on the Schwartz core of `L²(V)`.
With the Minkowski coefficients this is `□` with a constant drift and a constant
potential. -/
theorem mixedOp_essentiallySelfAdjoint (a c : ι → ℝ) (w : ι → V) (κ : ℝ) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain V)
      (opL2 (mixedOp a c w κ)) :=
  essentiallySelfAdjointOn_of_real_symbol _ _ (fourier_mixedOp_apply a c w κ)
    (contDiff_mixedSymbolFn a c w κ)

end BookProof.FourierMultiplierEsa
