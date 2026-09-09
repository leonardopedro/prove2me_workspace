import Mathlib
import BookProof.ChapterStrichartzWave
import BookProof.ChapterWaveBoundedPotential

/-!
# Unbounded (polynomial) potentials: what is proved, and where the obstruction lies

`BookProof.ChapterWaveBoundedPotential` proves `□ + V` essentially self-adjoint on the
Schwartz core of `L²(ℝ^{1+n})` for a real **essentially bounded** `V`.  The next target
recorded in `CONSOLIDATED_PLAN.md` §9.5 is the unbounded case: a potential which is a
polynomial (hence unbounded) but bounded below, via the three steps

> (a) localize with `exists_smooth_cutoff`, so that on each ball the truncated potential is
> essentially bounded; (b) apply `wave_add_potential_essentiallySelfAdjoint` to each
> truncation; (c) pass to the limit `R → ∞`.

This module carries out (a) and (b) unconditionally, adds the unbounded-potential theorem
that the *potential alone* is essentially self-adjoint, and states precisely what (c) needs.

## Contents

* **Multiplication by an unbounded potential.**  `potentialOp W` is multiplication by a real
  function `W` of temperate growth — every polynomial qualifies, so the operator is
  genuinely unbounded.  `potentialOp_symmetric` and `potentialOp_essentiallySelfAdjoint`
  show that it is symmetric and essentially self-adjoint on the Schwartz core, with **no**
  boundedness and **no** semiboundedness hypothesis.  The proof is the position-space twin
  of the Fourier-multiplier argument of `ChapterStrichartzWave`: a deficiency vector `u`
  satisfies `∫ conj ψ · (W - z) · u = 0` for every Schwartz `ψ`, and dividing a smooth
  compactly supported `χ` by the nowhere-vanishing smooth function `W - z̄` produces such a
  `ψ` with `conj ψ · (W - z) = χ`, whence `u = 0`.
  `polynomialPotential_essentiallySelfAdjoint` is the special case `W x = ‖x‖^(2k)`, an
  unbounded polynomial potential which is bounded below.

* **The operator `□ + W` for an unbounded `W`.**  It is well defined on the Schwartz core
  (Schwartz space is invariant under multiplication by a temperate function) and symmetric:
  `wave_add_potentialOp_symmetric`.  This is the precise Lean statement of the target
  operator of §9.5.

* **Steps (a)+(b): localization.**  `opL2_potentialOp_eq_mulL2` identifies the
  multiplication operator of this module with the bounded `mulL2` of
  `ChapterWaveBoundedPotential` whenever the potential is essentially bounded, so the
  bounded theorem applies verbatim to the truncations:
  `wave_add_boundedPotentialOp_essentiallySelfAdjoint` and, for a potential of temperate
  growth cut off at radius `R`, `wave_add_truncatedPotential_essentiallySelfAdjoint` —
  for every `R` there is a `W_R` of temperate growth, agreeing with `W` on the ball of
  radius `R`, with `□ + W_R` essentially self-adjoint on the Schwartz core.

* **Step (c): the residue, and a sign warning.**  Passing from the truncations to `□ + W`
  is not a formal limit, and the failure is not merely technical.  With the sign convention
  of this project (`□ = -∂_t² + Δ_x`), a Fourier transform in the time variable turns
  `□ + W` (for `W` a function of the space variables) into the fibre operators
  `4π²τ² - (-Δ_x - W)`.  A potential **bounded below** therefore makes the fibre Schrödinger
  operator `-Δ_x - W` unbounded **below**, which is exactly the limit-circle regime where
  essential self-adjointness fails (`-d²/dx² - x⁴` has deficiency indices `(2,2)`).  The
  sign under which the localization argument can close is the opposite one: `W` bounded
  *above* for `□ = -∂_t² + Δ_x`, equivalently `W` bounded below for the opposite-signature
  convention `□ = ∂_t² - Δ_x` used in the physics literature.  Nothing here claims the
  unbounded case; the theorems below are exactly the unconditional part.
-/

namespace BookProof.StrichartzWave

open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

/-! ## Multiplication by an unbounded real potential -/

/-- Multiplication by a real potential `W`, as an operator on Schwartz space.  The operator
is well defined (Schwartz space is invariant) as soon as `W` has temperate growth, which
holds for every polynomial; no boundedness is required. -/
noncomputable def potentialOp (W : V → ℝ) : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ) :=
  SchwartzMap.smulLeftCLM ℂ (fun x => (W x : ℂ))

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
lemma hasTemperateGrowth_ofReal {W : V → ℝ} (hW : Function.HasTemperateGrowth W) :
    Function.HasTemperateGrowth (fun x => (W x : ℂ)) := by
  simpa using Function.HasTemperateGrowth.comp Complex.ofRealCLM.hasTemperateGrowth hW

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
@[simp] lemma potentialOp_apply {W : V → ℝ} (hW : Function.HasTemperateGrowth W)
    (f : 𝓢(V, ℂ)) (x : V) : potentialOp W f x = (W x : ℂ) * f x := by
  simp [potentialOp, SchwartzMap.smulLeftCLM_apply_apply (hasTemperateGrowth_ofReal hW)]

/-- A real potential of temperate growth is a symmetric operator on the Schwartz core. -/
theorem potentialOp_symmetric (W : V → ℝ) (hW : Function.HasTemperateGrowth W) :
    BookProof.FarisLavine.SymmetricOn (schwartzDomain V) (opL2 (potentialOp W)) := by
  intro x y
  obtain ⟨f, rfl⟩ := (schwartzEquiv V).surjective x
  obtain ⟨g, rfl⟩ := (schwartzEquiv V).surjective y
  rw [opL2_apply, opL2_apply, schwartzEquiv_coe, schwartzEquiv_coe, inner_toLp_left,
    inner_toLp_left]
  refine integral_congr_ae ?_
  filter_upwards [g.coeFn_toLp 2 (volume : Measure V),
    (potentialOp W g).coeFn_toLp 2 (volume : Measure V)] with x hx hy
  rw [hx, hy]
  simp only [potentialOp_apply hW, map_mul, Complex.conj_ofReal]
  ring

/-- The deficiency identity for the potential: testing against a Schwartz function `ψ`. -/
lemma integral_conj_mul_potential_sub_eq_zero (W : V → ℝ) (hW : Function.HasTemperateGrowth W)
    (z : ℂ) (u : Lp ℂ 2 (volume : Measure V))
    (hu : ∀ v : schwartzDomain V,
      (inner ℂ (opL2 (potentialOp W) v) u : ℂ) = z * inner ℂ (v : Lp ℂ 2 _) u)
    (ψ : 𝓢(V, ℂ)) :
    ∫ x, (starRingEnd ℂ) (ψ x) * (((W x : ℝ) : ℂ) - z) * (u x) = 0 := by
  have h1 := hu (schwartzEquiv V ψ)
  rw [opL2_apply, schwartzEquiv_coe, inner_toLp_left, inner_toLp_left] at h1
  have hL : ∫ x, (starRingEnd ℂ) ((potentialOp W ψ) x) * (u x)
      = ∫ x, ((W x : ℝ) : ℂ) * ((starRingEnd ℂ) (ψ x) * (u x)) := by
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only [potentialOp_apply hW, map_mul, Complex.conj_ofReal]
    ring
  rw [hL] at h1
  have hint1 : Integrable (fun x => (starRingEnd ℂ) (ψ x) * (u x)) (volume : Measure V) :=
    integrable_conj_schwartz_mul ψ u
  have hint2 : Integrable (fun x => ((W x : ℝ) : ℂ) * ((starRingEnd ℂ) (ψ x) * (u x)))
      (volume : Measure V) := by
    have := integrable_conj_schwartz_mul (potentialOp W ψ) u
    refine this.congr (Filter.Eventually.of_forall fun x => ?_)
    simp only [potentialOp_apply hW, map_mul, Complex.conj_ofReal]
    ring
  have hcomb : ∫ x, (((W x : ℝ) : ℂ) * ((starRingEnd ℂ) (ψ x) * (u x))
      - z * ((starRingEnd ℂ) (ψ x) * (u x))) = 0 := by
    rw [integral_sub hint2 (hint1.const_mul z), MeasureTheory.integral_const_mul, h1]
    ring
  rw [← hcomb]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  ring

/-- **Vanishing deficiency spaces for an unbounded real potential.** -/
theorem potentialOp_deficiencyTrivial (W : V → ℝ) (hW : Function.HasTemperateGrowth W)
    {z : ℂ} (hz : z.im ≠ 0) :
    BookProof.FarisLavine.DeficiencyTrivialAt (schwartzDomain V) (opL2 (potentialOp W)) z := by
  intro u hu
  have hWsmooth : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W := hW.1
  have hz1 : ∀ x : V, ((W x : ℝ) : ℂ) - (starRingEnd ℂ) z ≠ 0 := by
    intro x hx
    exact hz (by simpa using congrArg Complex.im hx)
  have hz2 : ∀ x : V, ((W x : ℝ) : ℂ) - z ≠ 0 := by
    intro x hx
    exact hz (by simpa using congrArg Complex.im hx)
  have main : ∀ χ : V → ℝ, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) χ → HasCompactSupport χ →
      ∫ x, χ x • (u x) = 0 := by
    intro χ hχ hχc
    have hsmooth : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞)
        (fun x => (χ x : ℂ) * (((W x : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹) := by
      refine (Complex.ofRealCLM.contDiff.comp hχ).mul (ContDiff.inv ?_ hz1)
      exact (Complex.ofRealCLM.contDiff.comp hWsmooth).sub contDiff_const
    have hsupp : HasCompactSupport
        (fun x => (χ x : ℂ) * (((W x : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹) := by
      refine HasCompactSupport.mul_right ?_
      simpa using hχc.comp_left (g := fun r : ℝ => (r : ℂ)) (by simp)
    obtain ⟨ψ, hψcoe⟩ : ∃ ψ : 𝓢(V, ℂ), (ψ : V → ℂ) =
        fun x => (χ x : ℂ) * (((W x : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹ :=
      ⟨hsupp.toSchwartzMap hsmooth, rfl⟩
    have key := integral_conj_mul_potential_sub_eq_zero W hW z u hu ψ
    rw [← key]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    have hpx : ψ x = (χ x : ℂ) * (((W x : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹ := congrFun hψcoe x
    have hc : (starRingEnd ℂ) (ψ x) * (((W x : ℝ) : ℂ) - z) = (χ x : ℂ) := by
      rw [hpx]
      simp only [map_mul, map_inv₀, map_sub, Complex.conj_ofReal, Complex.conj_conj]
      field_simp
      exact mul_div_cancel_right₀ _ (hz2 x)
    change χ x • (u x) = (starRingEnd ℂ) (ψ x) * (((W x : ℝ) : ℂ) - z) * (u x)
    rw [Complex.real_smul, ← hc]
  have hloc : LocallyIntegrable (fun x => (u x : ℂ)) (volume : Measure V) :=
    (Lp.memLp u).locallyIntegrable (by norm_num)
  have hae : ∀ᵐ x ∂(volume : Measure V), (u x : ℂ) = 0 :=
    ae_eq_zero_of_integral_contDiff_smul_eq_zero hloc (fun χ hχ hχc => main χ hχ hχc)
  exact Lp.eq_zero_iff_ae_eq_zero.mpr hae

/-- **An unbounded real potential is essentially self-adjoint on the Schwartz core.**  No
boundedness (and no semiboundedness) hypothesis is needed: temperate growth, which every
polynomial satisfies, is enough. -/
theorem potentialOp_essentiallySelfAdjoint (W : V → ℝ) (hW : Function.HasTemperateGrowth W) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain V) (opL2 (potentialOp W)) :=
  ⟨potentialOp_deficiencyTrivial W hW (by simp),
    potentialOp_deficiencyTrivial W hW (by simp)⟩

/-- The polynomial potential `W x = ‖x‖^(2k)` — unbounded, and bounded below — is
essentially self-adjoint on the Schwartz core. -/
theorem polynomialPotential_essentiallySelfAdjoint (k : ℕ) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain V)
      (opL2 (potentialOp (fun x : V => ‖x‖ ^ (2 * k)))) := by
  have h : Function.HasTemperateGrowth (fun x : V => ‖x‖ ^ (2 * k)) := by
    have := (Function.hasTemperateGrowth_norm_sq (H := V)).pow k
    simpa [pow_mul] using this
  exact potentialOp_essentiallySelfAdjoint _ h

/-! ## The operator `□ + W` for an unbounded potential -/

lemma opL2_add (T S : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ)) : opL2 (T + S) = opL2 T + opL2 S :=
  LinearMap.ext fun v => by simp [opL2, map_add]

/-- The wave operator with an arbitrary real potential of temperate growth is symmetric on
the Schwartz core.  (Essential self-adjointness in this generality is *not* claimed; see the
module docstring.) -/
theorem wave_add_potentialOp_symmetric (n : ℕ) (W : SpaceTime n → ℝ)
    (hW : Function.HasTemperateGrowth W) :
    BookProof.FarisLavine.SymmetricOn (schwartzDomain (SpaceTime n))
      (opL2 (waveOp n 0 + potentialOp W)) := by
  intro x y
  have h1 := wave_symmetric n 0 x y
  have h2 := potentialOp_symmetric W hW x y
  simp only [opL2_add, LinearMap.add_apply, inner_add_left, inner_add_right]
  linear_combination h1 + h2

/-! ## The dual statement: arbitrary real Fourier multipliers

The potential theorem above is the position-space half of the picture.  Conjugating it with
the Fourier transform gives the momentum-space half: *every* real symbol of temperate growth
— not just the quadratic symbols of `constCoeffOp` — defines an essentially self-adjoint
operator on the Schwartz core.  This covers all constant-coefficient differential operators
with real symbol of any order, for instance `□²` and the polyharmonic operators `(-Δ)^k`. -/

/-- The Fourier multiplier with symbol `m`, as an operator on Schwartz space. -/
noncomputable def multiplierOp (m : V → ℝ) : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ) :=
  (FourierTransform.fourierCLE ℂ 𝓢(V, ℂ)).symm.toContinuousLinearMap ∘L potentialOp m ∘L
    (FourierTransform.fourierCLE ℂ 𝓢(V, ℂ)).toContinuousLinearMap

lemma multiplierOp_apply_eq (m : V → ℝ) (f : 𝓢(V, ℂ)) :
    (multiplierOp m f : 𝓢(V, ℂ)) = 𝓕⁻ (potentialOp m (𝓕 f : 𝓢(V, ℂ))) := rfl

/-- Under the Fourier transform, `multiplierOp m` is multiplication by `m`. -/
lemma fourier_multiplierOp_apply {m : V → ℝ} (hm : Function.HasTemperateGrowth m)
    (f : 𝓢(V, ℂ)) (x : V) :
    (𝓕 (multiplierOp m f) : 𝓢(V, ℂ)) x = ((m x : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x := by
  rw [multiplierOp_apply_eq, fourier_fourierInv_eq, potentialOp_apply hm]

/-- The Fourier multiplier with a real symbol is symmetric on the Schwartz core. -/
theorem multiplierOp_symmetric (m : V → ℝ) (hm : Function.HasTemperateGrowth m) :
    BookProof.FarisLavine.SymmetricOn (schwartzDomain V) (opL2 (multiplierOp m)) := by
  intro x y
  obtain ⟨f, rfl⟩ := (schwartzEquiv V).surjective x
  obtain ⟨g, rfl⟩ := (schwartzEquiv V).surjective y
  rw [opL2_apply, opL2_apply, schwartzEquiv_coe, schwartzEquiv_coe,
    inner_toLp_eq_integral_fourier, inner_toLp_eq_integral_fourier]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only [fourier_multiplierOp_apply hm, map_mul, Complex.conj_ofReal]
  ring

/-- The deficiency identity for a Fourier multiplier, on the Fourier side. -/
lemma integral_conj_mul_multiplier_sub_eq_zero (m : V → ℝ) (hm : Function.HasTemperateGrowth m)
    (z : ℂ) (u : Lp ℂ 2 (volume : Measure V))
    (hu : ∀ v : schwartzDomain V,
      (inner ℂ (opL2 (multiplierOp m) v) u : ℂ) = z * inner ℂ (v : Lp ℂ 2 _) u)
    (ψ : 𝓢(V, ℂ)) :
    ∫ x, (starRingEnd ℂ) (ψ x) * (((m x : ℝ) : ℂ) - z) *
      ((𝓕 u : Lp ℂ 2 (volume : Measure V)) x) = 0 := by
  set g : Lp ℂ 2 (volume : Measure V) := 𝓕 u with hg
  set f : 𝓢(V, ℂ) := 𝓕⁻ ψ with hfdef
  have hf : (𝓕 f : 𝓢(V, ℂ)) = ψ := fourier_fourierInv_eq ψ
  have h1 := hu (schwartzEquiv V f)
  rw [opL2_apply, schwartzEquiv_coe, inner_toLp_left_fourier, inner_toLp_left_fourier] at h1
  have hL : ∫ x, (starRingEnd ℂ) ((𝓕 (multiplierOp m f) : 𝓢(V, ℂ)) x) * (g x)
      = ∫ x, ((m x : ℝ) : ℂ) * ((starRingEnd ℂ) (ψ x) * (g x)) := by
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only [fourier_multiplierOp_apply hm, hf, map_mul, Complex.conj_ofReal]
    ring
  rw [hL, hf] at h1
  have hint1 : Integrable (fun x => (starRingEnd ℂ) (ψ x) * (g x)) (volume : Measure V) :=
    integrable_conj_schwartz_mul ψ g
  have hint2 : Integrable (fun x => ((m x : ℝ) : ℂ) * ((starRingEnd ℂ) (ψ x) * (g x)))
      (volume : Measure V) := by
    have := integrable_conj_schwartz_mul (𝓕 (multiplierOp m f) : 𝓢(V, ℂ)) g
    refine this.congr (Filter.Eventually.of_forall fun x => ?_)
    simp only [fourier_multiplierOp_apply hm, hf, map_mul, Complex.conj_ofReal]
    ring
  have hcomb : ∫ x, (((m x : ℝ) : ℂ) * ((starRingEnd ℂ) (ψ x) * (g x))
      - z * ((starRingEnd ℂ) (ψ x) * (g x))) = 0 := by
    rw [integral_sub hint2 (hint1.const_mul z), MeasureTheory.integral_const_mul, h1]
    ring
  rw [← hcomb]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  ring

/-- **Vanishing deficiency spaces for a Fourier multiplier with a real symbol.** -/
theorem multiplierOp_deficiencyTrivial (m : V → ℝ) (hm : Function.HasTemperateGrowth m)
    {z : ℂ} (hz : z.im ≠ 0) :
    BookProof.FarisLavine.DeficiencyTrivialAt (schwartzDomain V) (opL2 (multiplierOp m)) z := by
  intro u hu
  have hmsmooth : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) m := hm.1
  have hz1 : ∀ x : V, ((m x : ℝ) : ℂ) - (starRingEnd ℂ) z ≠ 0 := by
    intro x hx
    exact hz (by simpa using congrArg Complex.im hx)
  have hz2 : ∀ x : V, ((m x : ℝ) : ℂ) - z ≠ 0 := by
    intro x hx
    exact hz (by simpa using congrArg Complex.im hx)
  have main : ∀ χ : V → ℝ, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) χ → HasCompactSupport χ →
      ∫ x, χ x • ((𝓕 u : Lp ℂ 2 (volume : Measure V)) x) = 0 := by
    intro χ hχ hχc
    have hsmooth : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞)
        (fun x => (χ x : ℂ) * (((m x : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹) := by
      refine (Complex.ofRealCLM.contDiff.comp hχ).mul (ContDiff.inv ?_ hz1)
      exact (Complex.ofRealCLM.contDiff.comp hmsmooth).sub contDiff_const
    have hsupp : HasCompactSupport
        (fun x => (χ x : ℂ) * (((m x : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹) := by
      refine HasCompactSupport.mul_right ?_
      simpa using hχc.comp_left (g := fun r : ℝ => (r : ℂ)) (by simp)
    obtain ⟨ψ, hψcoe⟩ : ∃ ψ : 𝓢(V, ℂ), (ψ : V → ℂ) =
        fun x => (χ x : ℂ) * (((m x : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹ :=
      ⟨hsupp.toSchwartzMap hsmooth, rfl⟩
    have key := integral_conj_mul_multiplier_sub_eq_zero m hm z u hu ψ
    rw [← key]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    have hpx : ψ x = (χ x : ℂ) * (((m x : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹ := congrFun hψcoe x
    have hc : (starRingEnd ℂ) (ψ x) * (((m x : ℝ) : ℂ) - z) = (χ x : ℂ) := by
      rw [hpx]
      simp only [map_mul, map_inv₀, map_sub, Complex.conj_ofReal, Complex.conj_conj]
      field_simp
      exact mul_div_cancel_right₀ _ (hz2 x)
    change χ x • ((𝓕 u : Lp ℂ 2 (volume : Measure V)) x)
      = (starRingEnd ℂ) (ψ x) * (((m x : ℝ) : ℂ) - z) *
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

/-- **Every real symbol of temperate growth gives an essentially self-adjoint Fourier
multiplier** on the Schwartz core of `L²(V)`.  This generalizes
`constCoeffOp_essentiallySelfAdjoint` from quadratic symbols to arbitrary real symbols of
temperate growth (any order, e.g. `□²` or `(-Δ)^k`). -/
theorem multiplierOp_essentiallySelfAdjoint (m : V → ℝ) (hm : Function.HasTemperateGrowth m) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain V) (opL2 (multiplierOp m)) :=
  ⟨multiplierOp_deficiencyTrivial m hm (by simp),
    multiplierOp_deficiencyTrivial m hm (by simp)⟩

section ConstCoeff

variable {ι : Type*} [Fintype ι]

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
lemma hasTemperateGrowth_symbolFn (c : ι → ℝ) (w : ι → V) (κ : ℝ) :
    Function.HasTemperateGrowth (symbolFn c w κ) := by
  refine Function.HasTemperateGrowth.add
    (Function.HasTemperateGrowth.sum fun i _ => ?_) (Function.HasTemperateGrowth.const κ)
  exact (Function.HasTemperateGrowth.const (c i * (-4 * Real.pi ^ 2))).mul
    ((Function.hasTemperateGrowth_inner_left (w i)).pow 2)

/-- The constant-coefficient operators of `ChapterStrichartzWave` are exactly the Fourier
multipliers with the (quadratic) symbol `symbolFn`, so `multiplierOp_essentiallySelfAdjoint`
is a strict generalization of `constCoeffOp_essentiallySelfAdjoint`. -/
theorem constCoeffOp_eq_multiplierOp (c : ι → ℝ) (w : ι → V) (κ : ℝ) :
    constCoeffOp c w κ = multiplierOp (symbolFn c w κ) := by
  refine ContinuousLinearMap.ext fun f => ?_
  refine (FourierTransform.fourierCLE ℂ 𝓢(V, ℂ)).injective (SchwartzMap.ext fun x => ?_)
  change (𝓕 (constCoeffOp c w κ f) : 𝓢(V, ℂ)) x
    = (𝓕 (multiplierOp (symbolFn c w κ) f) : 𝓢(V, ℂ)) x
  rw [fourier_constCoeffOp_apply, fourier_multiplierOp_apply (hasTemperateGrowth_symbolFn c w κ)]

end ConstCoeff

/-- The polyharmonic operator `(-Δ)^k`, whose symbol is `(4π²‖ξ‖²)^k`, is essentially
self-adjoint on the Schwartz core — an example of a real symbol of degree `2k` which is not
covered by the quadratic `constCoeffOp`. -/
theorem polyharmonic_multiplier_essentiallySelfAdjoint (k : ℕ) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain V)
      (opL2 (multiplierOp (fun ξ : V => (4 * Real.pi ^ 2 * ‖ξ‖ ^ 2) ^ k))) := by
  have h : Function.HasTemperateGrowth (fun ξ : V => (4 * Real.pi ^ 2 * ‖ξ‖ ^ 2) ^ k) :=
    (((Function.HasTemperateGrowth.const (4 * Real.pi ^ 2)).mul
      (Function.hasTemperateGrowth_norm_sq (H := V))).pow k)
  exact multiplierOp_essentiallySelfAdjoint _ h

/-! ## Localization: the truncated potential -/

/-- A continuous, compactly supported real function is essentially bounded. -/
lemma memLp_top_of_continuous_of_hasCompactSupport {W : V → ℝ} (hW : Continuous W)
    (hWc : HasCompactSupport W) :
    MemLp (fun x => (W x : ℂ)) (⊤ : ℝ≥0∞) (volume : Measure V) := by
  have hc : Continuous (fun x => (W x : ℂ)) := Complex.continuous_ofReal.comp hW
  have hcs : HasCompactSupport (fun x => (W x : ℂ)) := by
    simpa using hWc.comp_left (g := fun r : ℝ => (r : ℂ)) (by simp)
  exact hc.memLp_top_of_hasCompactSupport hcs (volume : Measure V)

/-- For an essentially bounded potential the multiplication operator of this module is the
bounded operator `mulL2` of `ChapterWaveBoundedPotential`. -/
lemma opL2_potentialOp_apply_eq_mulL2 (W : V → ℝ) (hW : Function.HasTemperateGrowth W)
    (hmem : MemLp (fun x => (W x : ℂ)) (⊤ : ℝ≥0∞) (volume : Measure V)) (f : 𝓢(V, ℂ)) :
    opL2 (potentialOp W) (schwartzEquiv V f)
      = mulL2 (hmem.toLp _) (f.toLp 2 (volume : Measure V)) := by
  rw [opL2_apply]
  refine MeasureTheory.Lp.ext ?_
  filter_upwards [(potentialOp W f).coeFn_toLp 2 (volume : Measure V),
    mulL2_coeFn (hmem.toLp _) (f.toLp 2 (volume : Measure V)),
    hmem.coeFn_toLp, f.coeFn_toLp 2 (volume : Measure V)] with x h1 h2 h3 h4
  rw [h1, h2, h3, h4]
  simp only [potentialOp_apply hW]

lemma opL2_potentialOp_eq_mulL2 (W : V → ℝ) (hW : Function.HasTemperateGrowth W)
    (hmem : MemLp (fun x => (W x : ℂ)) (⊤ : ℝ≥0∞) (volume : Measure V)) :
    opL2 (potentialOp W)
      = (mulL2 (hmem.toLp _)).toLinearMap ∘ₗ (schwartzDomain V).subtype := by
  refine LinearMap.ext fun v => ?_
  obtain ⟨f, rfl⟩ := (schwartzEquiv V).surjective v
  simpa using opL2_potentialOp_apply_eq_mulL2 W hW hmem f

/-- `□ + W` is essentially self-adjoint on the Schwartz core for every real potential `W`
of temperate growth which is (essentially) bounded. -/
theorem wave_add_boundedPotentialOp_essentiallySelfAdjoint (n : ℕ) (W : SpaceTime n → ℝ)
    (hW : Function.HasTemperateGrowth W)
    (hmem : MemLp (fun x => (W x : ℂ)) (⊤ : ℝ≥0∞) (volume : Measure (SpaceTime n))) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain (SpaceTime n))
      (opL2 (waveOp n 0 + potentialOp W)) := by
  rw [opL2_add, opL2_potentialOp_eq_mulL2 W hW hmem]
  exact wave_add_potential_essentiallySelfAdjoint n W hmem

/-- **Steps (a) and (b) of the localization plan.**  For a real potential `W` of temperate
growth — a polynomial, say — and every radius `R`, there is a truncation `W_R` of temperate
growth which agrees with `W` on the closed ball of radius `R`, vanishes outside the ball of
radius `R + 1`, and for which `□ + W_R` is essentially self-adjoint on the Schwartz core of
`L²(ℝ^{1+n})`. -/
theorem wave_add_truncatedPotential_essentiallySelfAdjoint (n : ℕ) (W : SpaceTime n → ℝ)
    (hW : Function.HasTemperateGrowth W) (R : ℝ) :
    ∃ WR : SpaceTime n → ℝ, Function.HasTemperateGrowth WR ∧
      (∀ x, ‖x‖ ≤ R → WR x = W x) ∧ (∀ x, R + 1 ≤ ‖x‖ → WR x = 0) ∧
      BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain (SpaceTime n))
        (opL2 (waveOp n 0 + potentialOp WR)) := by
  obtain ⟨χ, hχsmooth, hχc, hχone, -, hχzero, -⟩ := exists_smooth_cutoff (V := SpaceTime n) R
  have hWcont : Continuous W := hW.1.continuous
  have hcs : HasCompactSupport (fun x => W x * χ x) := hχc.mul_left
  have hsmooth : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (fun x => W x * χ x) := hW.1.mul hχsmooth
  refine ⟨fun x => W x * χ x, hcs.hasTemperateGrowth hsmooth, ?_, ?_, ?_⟩
  · intro x hx
    change W x * χ x = W x
    rw [hχone x hx, mul_one]
  · intro x hx
    change W x * χ x = 0
    rw [hχzero x hx, mul_zero]
  · refine wave_add_boundedPotentialOp_essentiallySelfAdjoint n _ (hcs.hasTemperateGrowth hsmooth)
      (memLp_top_of_continuous_of_hasCompactSupport (hWcont.mul hχsmooth.continuous) hcs)

end BookProof.StrichartzWave
