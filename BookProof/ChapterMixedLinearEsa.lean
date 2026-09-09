import Mathlib
import BookProof.ChapterFourierMultiplierEsa
import BookProof.ChapterWaveUnboundedPotential

/-!
# The mixed first-order operator `⟪x, b⟫ − i ∂_m`

`BookProof.ChapterShiftedQuadraticDegenerate` proves essential self-adjointness of the
inhomogeneous quadratic Hamiltonian `H_A + ∑ᵢ (bᵢ xᵢ + b'ᵢ πᵢ)` whenever the first-order
coefficients are orthogonal to the kernel of `A`, and records the residual case: in a
kernel direction the Hamiltonian degenerates to the *first-order* operator
`b x + b' π`, which has no `L²` eigenvector, so the Hermite-eigenbasis route cannot see
it.  `BookProof.ChapterFourierMultiplierEsa` settles the purely-momentum part `b' π` by
the Plancherel route.  This module settles the remaining, genuinely mixed case
`b x + b' π` with **both** coefficients non-zero.

## What is proved

* `posOp_essentiallySelfAdjoint` — **the position operator** (multiplication by the real
  linear function `x ↦ ⟪x, b⟫`) is symmetric and essentially self-adjoint on the Schwartz
  core of `L²(V)`.  The deficiency equation is killed by dividing a *compactly supported*
  test function by `⟪x, b⟫ − z̄`, so no Fourier transform is needed;
* `momentum_test_compactSupport_extend` — **compactly supported test functions suffice**
  for the momentum operator: if the deficiency identity of `π_m = −i ∂_m` holds against
  every smooth compactly supported test function, it holds against every Schwartz
  function.  The proof is a cut-off argument: `χ(x/n) f → f` and
  `π_m (χ(·/n) f) → π_m f` pointwise, with a uniform integrable dominating function;
* `gaugeFun`, `hasDerivAt_gaugeFun_line`, `mixedLinearOp_gauge` — **the gauge**: with the
  quadratic phase `θ(x) = −⟪x,b⟫⟪x,m⟫/‖m‖² + ⟪b,m⟫⟪x,m⟫²/(2‖m‖⁴)`, which satisfies
  `∂_m θ = −⟪x, b⟫`, the unimodular factor `e^{iθ}` intertwines the mixed operator with
  the pure momentum operator: `(⟪·,b⟫ − i∂_m)(e^{iθ}φ) = e^{iθ}(−i∂_m φ)`;
* `mixedLinearOp_essentiallySelfAdjoint` — **the headline**: for arbitrary `b, m ∈ V` the
  operator `⟪x, b⟫ − i ∂_m` is symmetric and essentially self-adjoint on the Schwartz core
  of `L²(V)`.  Multiplying a compactly supported test function by `e^{iθ}` keeps it
  compactly supported, which is why the previous item is exactly what the gauge argument
  needs (`e^{iθ}` is *not* known to preserve Schwartz space here).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.MixedLinearEsa

open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

/-! ## 1. The position operator -/

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
lemma hasTemperateGrowth_innerC (b : V) :
    (fun x : V => ((inner ℝ x b : ℝ) : ℂ)).HasTemperateGrowth :=
  Complex.ofRealCLM.hasTemperateGrowth.comp ((innerSL ℝ).flip b).hasTemperateGrowth

/-- Multiplication by the real linear function `x ↦ ⟪x, b⟫` on Schwartz space. -/
noncomputable def posOp (b : V) : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ) :=
  smulLeftCLM ℂ (fun x => ((inner ℝ x b : ℝ) : ℂ))

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
@[simp] lemma posOp_apply (b : V) (f : 𝓢(V, ℂ)) (x : V) :
    (posOp b f) x = ((inner ℝ x b : ℝ) : ℂ) * f x := by
  simp [posOp, smulLeftCLM_apply_apply (hasTemperateGrowth_innerC b)]

/-- The position operator is symmetric on the Schwartz core. -/
theorem posOp_symmetric (b : V) :
    SymmetricOn (schwartzDomain V) (opL2 (posOp b)) := by
  intro x y
  obtain ⟨f, rfl⟩ := (schwartzEquiv V).surjective x
  obtain ⟨g, rfl⟩ := (schwartzEquiv V).surjective y
  rw [opL2_apply, opL2_apply, schwartzEquiv_coe, schwartzEquiv_coe,
    inner_toLp_left, inner_toLp_left]
  refine integral_congr_ae ?_
  filter_upwards [(posOp b g).coeFn_toLp 2 (volume : Measure V),
    g.coeFn_toLp 2 (volume : Measure V)] with x h1 h2
  rw [h1, h2, posOp_apply, posOp_apply]
  simp only [map_mul, Complex.conj_ofReal]
  ring

/-- Testing the deficiency equation of the position operator against a Schwartz function. -/
lemma integral_conj_mul_pos_sub_eq_zero (b : V) (z : ℂ) (u : Lp ℂ 2 (volume : Measure V))
    (hu : ∀ v : schwartzDomain V,
      (inner ℂ (opL2 (posOp b) v) u : ℂ) = z * inner ℂ (v : Lp ℂ 2 _) u)
    (f : 𝓢(V, ℂ)) :
    ∫ x, (starRingEnd ℂ) (f x) * (((inner ℝ x b : ℝ) : ℂ) - z) * (u x) = 0 := by
  have h1 := hu (schwartzEquiv V f)
  rw [opL2_apply, schwartzEquiv_coe, inner_toLp_left, inner_toLp_left] at h1
  have hint1 : Integrable (fun x => (starRingEnd ℂ) (f x) * (u x)) (volume : Measure V) :=
    integrable_conj_schwartz_mul f u
  have hint2 : Integrable (fun x => (starRingEnd ℂ) ((posOp b f) x) * (u x))
      (volume : Measure V) := integrable_conj_schwartz_mul (posOp b f) u
  have hcomb : ∫ x, ((starRingEnd ℂ) ((posOp b f) x) * (u x)
      - z * ((starRingEnd ℂ) (f x) * (u x))) = 0 := by
    rw [integral_sub hint2 (hint1.const_mul z), MeasureTheory.integral_const_mul, h1]
    ring
  rw [← hcomb]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only [posOp_apply, map_mul, Complex.conj_ofReal]
  ring

/-- **The position operator has trivial deficiency spaces** at every non-real point. -/
theorem posOp_deficiencyTrivialAt (b : V) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (schwartzDomain V) (opL2 (posOp b)) z := by
  intro u hu
  have hz1 : ∀ x : V, ((inner ℝ x b : ℝ) : ℂ) - (starRingEnd ℂ) z ≠ 0 := by
    intro x hx
    exact hz (by simpa using congrArg Complex.im hx)
  have hz2 : ∀ x : V, ((inner ℝ x b : ℝ) : ℂ) - z ≠ 0 := by
    intro x hx
    exact hz (by simpa using congrArg Complex.im hx)
  have main : ∀ χ : V → ℝ, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) χ → HasCompactSupport χ →
      ∫ x, χ x • (u x) = 0 := by
    intro χ hχ hχc
    have hsmooth : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞)
        (fun x => (χ x : ℂ) * (((inner ℝ x b : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹) := by
      refine (Complex.ofRealCLM.contDiff.comp hχ).mul (ContDiff.inv ?_ hz1)
      exact (Complex.ofRealCLM.contDiff.comp (((innerSL ℝ).flip b).contDiff)).sub contDiff_const
    have hsupp : HasCompactSupport
        (fun x => (χ x : ℂ) * (((inner ℝ x b : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹) := by
      refine HasCompactSupport.mul_right ?_
      simpa using hχc.comp_left (g := fun r : ℝ => (r : ℂ)) (by simp)
    obtain ⟨ψ, hψcoe⟩ : ∃ ψ : 𝓢(V, ℂ), (ψ : V → ℂ) =
        fun x => (χ x : ℂ) * (((inner ℝ x b : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹ :=
      ⟨hsupp.toSchwartzMap hsmooth, rfl⟩
    have key := integral_conj_mul_pos_sub_eq_zero b z u hu ψ
    rw [← key]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    have hpx : ψ x = (χ x : ℂ) * (((inner ℝ x b : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹ :=
      congrFun hψcoe x
    have hc : (starRingEnd ℂ) (ψ x) * (((inner ℝ x b : ℝ) : ℂ) - z) = (χ x : ℂ) := by
      rw [hpx]
      simp only [map_mul, map_inv₀, map_sub, Complex.conj_ofReal, Complex.conj_conj]
      field_simp
      exact mul_div_cancel_right₀ _ (hz2 x)
    change χ x • (u x) = (starRingEnd ℂ) (ψ x) * (((inner ℝ x b : ℝ) : ℂ) - z) * (u x)
    rw [Complex.real_smul, ← hc]
  have hgloc : LocallyIntegrable (fun x => (u x : ℂ)) (volume : Measure V) :=
    (Lp.memLp u).locallyIntegrable (by norm_num)
  have hae : ∀ᵐ x ∂(volume : Measure V), (u x : ℂ) = 0 :=
    ae_eq_zero_of_integral_contDiff_smul_eq_zero hgloc (fun χ hχ hχc => main χ hχ hχc)
  exact Lp.eq_zero_iff_ae_eq_zero.mpr hae

/-- **The position operator is essentially self-adjoint** on the Schwartz core of `L²(V)`. -/
theorem posOp_essentiallySelfAdjoint (b : V) :
    EssentiallySelfAdjointOn (schwartzDomain V) (opL2 (posOp b)) :=
  ⟨posOp_deficiencyTrivialAt b (by simp), posOp_deficiencyTrivialAt b (by simp)⟩

/-! ## 2. The mixed operator -/

/-- The mixed first-order operator `⟪x, b⟫ − i ∂_m`. -/
noncomputable def mixedLinearOp (b m : V) : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ) :=
  posOp b + momentumOp m

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
lemma momentumOp_apply (m : V) (f : 𝓢(V, ℂ)) (x : V) :
    (momentumOp m f) x = (-Complex.I) * (fderiv ℝ f x m) := by
  simp [momentumOp, SchwartzMap.lineDerivOp_apply_eq_fderiv]

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
lemma mixedLinearOp_apply (b m : V) (f : 𝓢(V, ℂ)) (x : V) :
    (mixedLinearOp b m f) x
      = ((inner ℝ x b : ℝ) : ℂ) * f x + (-Complex.I) * (fderiv ℝ f x m) := by
  simp [mixedLinearOp, momentumOp_apply]

lemma opL2_add (A B : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ)) : opL2 (A + B) = opL2 A + opL2 B := by
  refine LinearMap.ext fun v => ?_
  simp only [opL2, LinearMap.coe_comp, Function.comp_apply, ContinuousLinearMap.coe_coe,
    ContinuousLinearMap.add_apply, LinearMap.add_apply, map_add]

/-- The mixed operator is symmetric on the Schwartz core. -/
theorem mixedLinearOp_symmetric (b m : V) :
    SymmetricOn (schwartzDomain V) (opL2 (mixedLinearOp b m)) := by
  have hmom : SymmetricOn (schwartzDomain V) (opL2 (momentumOp m)) :=
    symmetricOn_of_real_symbol (momentumOp m) (fun x => 2 * Real.pi * (inner ℝ x m))
      (fun f x => by simpa using fourier_momentumOp_apply f m x)
  rw [mixedLinearOp, opL2_add]
  intro x y
  simp only [LinearMap.add_apply, inner_add_left, inner_add_right, posOp_symmetric b x y,
    hmom x y]

/-! ## 3. Compactly supported test functions suffice for the momentum operator -/

omit [MeasurableSpace V] [BorelSpace V] in
/-- A sequence of smooth compactly supported cut-offs `χ(x/(n+1))`: bounded by `1`, with
uniformly bounded derivative, and eventually equal to `1` near any given point. -/
lemma exists_cutoff_seq :
    ∃ (cut : ℕ → V → ℝ) (K : ℝ),
      (∀ n, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (cut n)) ∧
      (∀ n, HasCompactSupport (cut n)) ∧
      (∀ n x, ‖cut n x‖ ≤ 1) ∧
      (∀ x : V, ∀ᶠ n in Filter.atTop, cut n x = 1 ∧ fderiv ℝ (cut n) x = 0) ∧
      (∀ n x, ‖fderiv ℝ (cut n) x‖ ≤ K) := by
  obtain ⟨χ, hχ, hχcs, hχ1, hχIcc, hχ0, -⟩ := exists_smooth_cutoff (V := V) 1
  obtain ⟨K, hK⟩ : ∃ K : ℝ, ∀ x, ‖fderiv ℝ χ x‖ ≤ K :=
    (hχcs.fderiv ℝ).exists_bound_of_continuous (hχ.continuous_fderiv (by simp))
  set c : ℕ → ℝ := fun n => ((n : ℝ) + 1)⁻¹ with hc
  have hcpos : ∀ n, 0 < c n := by
    intro n; positivity
  have hcle : ∀ n, c n ≤ 1 := by
    intro n
    have h1 : (1 : ℝ) ≤ (n : ℝ) + 1 := by linarith [Nat.cast_nonneg (α := ℝ) n]
    rw [hc]
    simpa using inv_le_one_of_one_le₀ h1
  set L : ℕ → (V →L[ℝ] V) := fun n => (c n) • ContinuousLinearMap.id ℝ V with hL
  have hLnorm : ∀ n, ‖L n‖ ≤ 1 := by
    intro n
    calc ‖L n‖ ≤ ‖c n‖ * ‖ContinuousLinearMap.id ℝ V‖ := norm_smul_le _ _
      _ ≤ 1 * 1 := by
          gcongr
          · rw [Real.norm_eq_abs, abs_of_pos (hcpos n)]; exact hcle n
          · exact ContinuousLinearMap.norm_id_le
      _ = 1 := by ring
  have hfd : ∀ n x, fderiv ℝ (fun y : V => χ (c n • y)) x
      = (fderiv ℝ χ (c n • x)).comp (L n) := by
    intro n x
    have hcomp : (fun y : V => χ (c n • y)) = χ ∘ (L n) := rfl
    rw [hcomp, fderiv_comp x (hχ.differentiable (by simp) _) ((L n).differentiableAt),
      (L n).fderiv]
    rfl
  refine ⟨fun n x => χ (c n • x), K, fun n => hχ.comp ((L n).contDiff), ?_, ?_, ?_, ?_⟩
  · intro n
    exact hχcs.comp_homeomorph (Homeomorph.smulOfNeZero (c n) (ne_of_gt (hcpos n)))
  · intro n x
    rcases hχIcc (c n • x) with ⟨h0, h1⟩
    rw [Real.norm_eq_abs, abs_of_nonneg h0]
    exact h1
  · intro x
    filter_upwards [Filter.eventually_ge_atTop ⌈‖x‖⌉₊] with n hn
    have hxn : ‖c n • x‖ < 1 := by
      rw [norm_smul, Real.norm_eq_abs, abs_of_pos (hcpos n)]
      have h1 : ‖x‖ ≤ (n : ℝ) := le_trans (Nat.le_ceil _) (by exact_mod_cast hn)
      rw [hc]
      simp only
      rw [inv_mul_lt_one₀ (by positivity)]
      linarith
    refine ⟨hχ1 _ (le_of_lt hxn), ?_⟩
    rw [hfd n x]
    have hzero : fderiv ℝ χ (c n • x) = 0 := by
      have heq : χ =ᶠ[nhds (c n • x)] (fun _ => (1 : ℝ)) := by
        have hball : Metric.ball (c n • x) (1 - ‖c n • x‖) ∈ nhds (c n • x) :=
          Metric.ball_mem_nhds _ (by linarith)
        filter_upwards [hball] with y hy
        refine hχ1 y (le_of_lt ?_)
        have hd := Metric.mem_ball.mp hy
        rw [dist_eq_norm] at hd
        calc ‖y‖ ≤ ‖c n • x‖ + ‖y - (c n • x)‖ := by
              simpa using norm_le_norm_add_norm_sub' y (c n • x)
          _ < ‖c n • x‖ + (1 - ‖c n • x‖) := by linarith
          _ = 1 := by ring
      rw [heq.fderiv_eq]
      simp
    rw [hzero]
    simp
  · intro n x
    have hKnn : 0 ≤ K := le_trans (norm_nonneg _) (hK (c n • x))
    rw [hfd n x]
    calc ‖(fderiv ℝ χ (c n • x)).comp (L n)‖ ≤ ‖fderiv ℝ χ (c n • x)‖ * ‖L n‖ :=
          ContinuousLinearMap.opNorm_comp_le _ _
      _ ≤ K * 1 := mul_le_mul (hK _) (hLnorm n) (norm_nonneg _) hKnn
      _ = K := by ring

/-- Multiplying a Schwartz function by a smooth compactly supported real function. -/
noncomputable def cutSchwartz (g : V → ℝ) (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g)
    (hgcs : HasCompactSupport g) (f : 𝓢(V, ℂ)) : 𝓢(V, ℂ) :=
  ((hgcs.comp_left (g := fun r : ℝ => (r : ℂ)) (by simp)).mul_right).toSchwartzMap
    ((Complex.ofRealCLM.contDiff.comp hg).mul (f.smooth ⊤))

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
@[simp] lemma cutSchwartz_apply (g : V → ℝ) (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g)
    (hgcs : HasCompactSupport g) (f : 𝓢(V, ℂ)) (x : V) :
    cutSchwartz g hg hgcs f x = ((g x : ℝ) : ℂ) * f x := rfl

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
lemma hasCompactSupport_cutSchwartz (g : V → ℝ) (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g)
    (hgcs : HasCompactSupport g) (f : 𝓢(V, ℂ)) :
    HasCompactSupport ((cutSchwartz g hg hgcs f : V → ℂ)) :=
  (hgcs.comp_left (g := fun r : ℝ => (r : ℂ)) (by simp)).mul_right

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
/-- The Leibniz rule for the momentum operator against a cut-off. -/
lemma momentumOp_cutSchwartz (m : V) (g : V → ℝ) (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g)
    (hgcs : HasCompactSupport g) (f : 𝓢(V, ℂ)) (x : V) :
    (momentumOp m (cutSchwartz g hg hgcs f)) x
      = -Complex.I * (f x * ((fderiv ℝ g x m : ℝ) : ℂ))
        + ((g x : ℝ) : ℂ) * (momentumOp m f x) := by
  have hgc : DifferentiableAt ℝ (fun y : V => ((g y : ℝ) : ℂ)) x :=
    (Complex.ofRealCLM.differentiable.comp (hg.differentiable (by simp))).differentiableAt
  have hfd : DifferentiableAt ℝ (f : V → ℂ) x := f.differentiableAt
  have hprod : fderiv ℝ ((cutSchwartz g hg hgcs f) : V → ℂ) x
      = (((g x : ℝ) : ℂ)) • fderiv ℝ (f : V → ℂ) x
        + (f x) • fderiv ℝ (fun y : V => ((g y : ℝ) : ℂ)) x := by
    have hco : ((cutSchwartz g hg hgcs f) : V → ℂ) = fun y => ((g y : ℝ) : ℂ) * f y := rfl
    rw [hco, fderiv_fun_mul hgc hfd]
  have hcast : fderiv ℝ (fun y : V => ((g y : ℝ) : ℂ)) x m = ((fderiv ℝ g x m : ℝ) : ℂ) := by
    have h1 : HasFDerivAt (fun y : V => ((g y : ℝ) : ℂ))
        (Complex.ofRealCLM.comp (fderiv ℝ g x)) x :=
      Complex.ofRealCLM.hasFDerivAt.comp x
        ((hg.differentiable (by simp)).differentiableAt.hasFDerivAt)
    rw [h1.fderiv]
    rfl
  rw [momentumOp_apply, hprod]
  simp only [ContinuousLinearMap.add_apply, ContinuousLinearMap.smul_apply, smul_eq_mul, hcast,
    momentumOp_apply]
  ring

/-- **Compactly supported test functions suffice for the momentum operator.**  The proof is
a cut-off argument: with `cut n → 1` locally and `fderiv (cut n) → 0` locally, the Leibniz
rule turns `π_m (cut n · f)` into `cut n · π_m f` plus a term bounded by `K‖m‖‖f‖`, and
dominated convergence (the dominating function is `(‖π_m f‖ + K‖m‖‖f‖)‖w‖`, integrable
because a Schwartz function times an `L²` function is integrable) passes both sides of the
identity to the limit. -/
lemma momentum_test_compactSupport_extend (m : V) (z : ℂ) (w : Lp ℂ 2 (volume : Measure V))
    (hw : ∀ φ : 𝓢(V, ℂ), HasCompactSupport (φ : V → ℂ) →
      ∫ x, (starRingEnd ℂ) ((momentumOp m φ) x) * (w x)
        = z * ∫ x, (starRingEnd ℂ) (φ x) * (w x))
    (f : 𝓢(V, ℂ)) :
    ∫ x, (starRingEnd ℂ) ((momentumOp m f) x) * (w x)
      = z * ∫ x, (starRingEnd ℂ) (f x) * (w x) := by
  obtain ⟨cut, K, hsm, hcs, hb1, hev, hbK⟩ := exists_cutoff_seq (V := V)
  set fn : ℕ → 𝓢(V, ℂ) := fun n => cutSchwartz (cut n) (hsm n) (hcs n) f with hfn
  -- the identity along the cut-off sequence
  have key : ∀ n, ∫ x, (starRingEnd ℂ) ((momentumOp m (fn n)) x) * (w x)
      = z * ∫ x, (starRingEnd ℂ) ((fn n) x) * (w x) :=
    fun n => hw _ (hasCompactSupport_cutSchwartz (cut n) (hsm n) (hcs n) f)
  -- integrability of the two dominating pieces
  have hint1 : Integrable (fun x => (starRingEnd ℂ) ((momentumOp m f) x) * (w x))
      (volume : Measure V) := integrable_conj_schwartz_mul (momentumOp m f) w
  have hint2 : Integrable (fun x => (starRingEnd ℂ) (f x) * (w x)) (volume : Measure V) :=
    integrable_conj_schwartz_mul f w
  have hKnn : 0 ≤ K := le_trans (norm_nonneg _) (hbK 0 0)
  set bnd : V → ℝ := fun x => ‖(starRingEnd ℂ) ((momentumOp m f) x) * (w x)‖
      + (K * ‖m‖) * ‖(starRingEnd ℂ) (f x) * (w x)‖ with hbnd
  have hbndint : Integrable bnd (volume : Measure V) :=
    hint1.norm.add (hint2.norm.const_mul (K * ‖m‖))
  -- the left-hand sides converge
  have hL : Filter.Tendsto (fun n => ∫ x, (starRingEnd ℂ) ((momentumOp m (fn n)) x) * (w x))
      Filter.atTop (nhds (∫ x, (starRingEnd ℂ) ((momentumOp m f) x) * (w x))) := by
    refine MeasureTheory.tendsto_integral_of_dominated_convergence bnd
      (fun n => (integrable_conj_schwartz_mul (momentumOp m (fn n)) w).aestronglyMeasurable)
      hbndint (fun n => Filter.Eventually.of_forall fun x => ?_)
      (Filter.Eventually.of_forall fun x => ?_)
    · rw [momentumOp_cutSchwartz m (cut n) (hsm n) (hcs n) f x]
      have hd : ‖((fderiv ℝ (cut n) x m : ℝ) : ℂ)‖ ≤ K * ‖m‖ := by
        rw [Complex.norm_real, Real.norm_eq_abs, ← Real.norm_eq_abs]
        exact le_trans ((fderiv ℝ (cut n) x).le_opNorm m)
          (mul_le_mul_of_nonneg_right (hbK n x) (norm_nonneg m))
      have hc1 : ‖((cut n x : ℝ) : ℂ)‖ ≤ 1 := by
        rw [Complex.norm_real]
        exact hb1 n x
      calc ‖(starRingEnd ℂ) (-Complex.I * (f x * ((fderiv ℝ (cut n) x m : ℝ) : ℂ))
              + ((cut n x : ℝ) : ℂ) * (momentumOp m f x)) * (w x)‖
          ≤ ‖(starRingEnd ℂ) (-Complex.I * (f x * ((fderiv ℝ (cut n) x m : ℝ) : ℂ))) * (w x)‖
            + ‖(starRingEnd ℂ) (((cut n x : ℝ) : ℂ) * (momentumOp m f x)) * (w x)‖ := by
            rw [map_add, add_mul]
            exact norm_add_le _ _
        _ ≤ (K * ‖m‖) * ‖(starRingEnd ℂ) (f x) * (w x)‖
            + ‖(starRingEnd ℂ) ((momentumOp m f) x) * (w x)‖ := by
            gcongr ?_ + ?_
            · simp only [map_mul, norm_mul, RCLike.norm_conj, norm_neg, Complex.norm_I, one_mul]
              nlinarith [hd, norm_nonneg (f x), norm_nonneg (w x : ℂ),
                mul_nonneg (norm_nonneg (f x)) (norm_nonneg (w x : ℂ)),
                norm_nonneg (((fderiv ℝ (cut n) x m : ℝ) : ℂ))]
            · simp only [map_mul, norm_mul, RCLike.norm_conj]
              nlinarith [hc1, norm_nonneg ((momentumOp m f) x), norm_nonneg (w x : ℂ),
                mul_nonneg (norm_nonneg ((momentumOp m f) x)) (norm_nonneg (w x : ℂ)),
                norm_nonneg (((cut n x : ℝ) : ℂ))]
        _ = bnd x := by rw [hbnd]; ring
    · refine Filter.Tendsto.congr' ?_ tendsto_const_nhds
      filter_upwards [hev x] with n hn
      rw [momentumOp_cutSchwartz m (cut n) (hsm n) (hcs n) f x, hn.1]
      have h0 : fderiv ℝ (cut n) x m = 0 := by rw [hn.2]; rfl
      rw [h0]
      simp
  -- the right-hand sides converge
  have hR : Filter.Tendsto (fun n => ∫ x, (starRingEnd ℂ) ((fn n) x) * (w x))
      Filter.atTop (nhds (∫ x, (starRingEnd ℂ) (f x) * (w x))) := by
    refine MeasureTheory.tendsto_integral_of_dominated_convergence
      (fun x => ‖(starRingEnd ℂ) (f x) * (w x)‖)
      (fun n => (integrable_conj_schwartz_mul (fn n) w).aestronglyMeasurable)
      hint2.norm (fun n => Filter.Eventually.of_forall fun x => ?_)
      (Filter.Eventually.of_forall fun x => ?_)
    · rw [hfn]
      simp only [cutSchwartz_apply, map_mul, norm_mul, RCLike.norm_conj, Complex.norm_real]
      nlinarith [hb1 n x, norm_nonneg (f x), norm_nonneg (w x : ℂ),
        mul_nonneg (norm_nonneg (f x)) (norm_nonneg (w x : ℂ)), norm_nonneg (cut n x)]
    · refine Filter.Tendsto.congr' ?_ tendsto_const_nhds
      filter_upwards [hev x] with n hn
      rw [hfn]
      simp [hn.1]
  have hzR : Filter.Tendsto (fun n => z * ∫ x, (starRingEnd ℂ) ((fn n) x) * (w x))
      Filter.atTop (nhds (z * ∫ x, (starRingEnd ℂ) (f x) * (w x))) := hR.const_mul z
  exact tendsto_nhds_unique (by simpa only [key] using hL) hzR

/-- **Compactly supported test functions detect the deficiency spaces of the momentum
operator.** -/
theorem momentumOp_eq_zero_of_compactSupport_test (m : V) {z : ℂ} (hz : z.im ≠ 0)
    (w : Lp ℂ 2 (volume : Measure V))
    (hw : ∀ φ : 𝓢(V, ℂ), HasCompactSupport (φ : V → ℂ) →
      ∫ x, (starRingEnd ℂ) ((momentumOp m φ) x) * (w x)
        = z * ∫ x, (starRingEnd ℂ) (φ x) * (w x)) :
    w = 0 := by
  refine deficiencyTrivialAt_of_real_symbol (momentumOp m)
    (fun x => 2 * Real.pi * (inner ℝ x m)) (fun f x => ?_) ?_ hz w ?_
  · simpa using fourier_momentumOp_apply f m x
  · exact contDiff_const.mul (((innerSL ℝ).flip m).contDiff)
  · intro v
    obtain ⟨f, rfl⟩ := (schwartzEquiv V).surjective v
    rw [opL2_apply, schwartzEquiv_coe, inner_toLp_left, inner_toLp_left]
    exact momentum_test_compactSupport_extend m z w hw f

/-! ## 4. The gauge -/

/-- The quadratic phase `θ(x) = −⟪x,b⟫⟪x,m⟫/‖m‖² + ⟪b,m⟫⟪x,m⟫²/(2‖m‖⁴)`, whose derivative
along `m` is `−⟪x, b⟫`. -/
noncomputable def gaugePhase (b m : V) (x : V) : ℝ :=
  -(inner ℝ x b) * (inner ℝ x m) / ‖m‖ ^ 2
    + (inner ℝ b m) * (inner ℝ x m) ^ 2 / (2 * ‖m‖ ^ 4)

/-- The unimodular gauge factor `e^{iθ}`. -/
noncomputable def gaugeFun (b m : V) (x : V) : ℂ :=
  Complex.exp (Complex.I * ((gaugePhase b m x : ℝ) : ℂ))

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
/-- The phase has directional derivative `−⟪x, b⟫` along `m`. -/
lemma hasDerivAt_gaugePhase_line (b m : V) (hm : m ≠ 0) (x : V) :
    HasDerivAt (fun t : ℝ => gaugePhase b m (x + t • m)) (-(inner ℝ x b : ℝ)) 0 := by
  set A : ℝ := inner ℝ x b with hA
  set B : ℝ := inner ℝ m b with hB
  set C : ℝ := inner ℝ x m with hC
  set D : ℝ := ‖m‖ ^ 2 with hD
  have hD0 : D ≠ 0 := by positivity
  have hbm : (inner ℝ b m : ℝ) = B := (real_inner_comm b m).symm
  have hfun : (fun t : ℝ => gaugePhase b m (x + t • m))
      = fun t : ℝ => (-(A + t * B)) * (C + t * D) / D + B * (C + t * D) ^ 2 / (2 * D ^ 2) := by
    funext t
    rw [gaugePhase, inner_add_left, inner_add_left, real_inner_smul_left, real_inner_smul_left,
      hbm, real_inner_self_eq_norm_sq]
    simp only [hA, hB, hC, hD]
    ring
  rw [hfun]
  have h1 : HasDerivAt (fun t : ℝ => A + t * B) B 0 := by
    simpa using ((hasDerivAt_id (0 : ℝ)).mul_const B).const_add A
  have h1n : HasDerivAt (fun t : ℝ => -(A + t * B)) (-B) 0 := h1.neg
  have h2 : HasDerivAt (fun t : ℝ => C + t * D) D 0 := by
    simpa using ((hasDerivAt_id (0 : ℝ)).mul_const D).const_add C
  have h3 := ((h1n.mul h2).div_const D).add (((h2.pow 2).const_mul B).div_const (2 * D ^ 2))
  simp only [Nat.cast_ofNat] at h3
  convert h3 using 1
  field_simp
  ring

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
lemma hasDerivAt_gaugeFun_line (b m : V) (hm : m ≠ 0) (x : V) :
    HasDerivAt (fun t : ℝ => gaugeFun b m (x + t • m))
      (gaugeFun b m x * (Complex.I * ((-(inner ℝ x b : ℝ) : ℝ) : ℂ))) 0 := by
  have h := hasDerivAt_gaugePhase_line b m hm x
  have h1 : HasDerivAt (fun t : ℝ => ((gaugePhase b m (x + t • m) : ℝ) : ℂ))
      (((-(inner ℝ x b : ℝ) : ℝ) : ℂ)) 0 := h.ofReal_comp
  have h2 : HasDerivAt (fun t : ℝ => Complex.I * ((gaugePhase b m (x + t • m) : ℝ) : ℂ))
      (Complex.I * ((-(inner ℝ x b : ℝ) : ℝ) : ℂ)) 0 := h1.const_mul _
  simpa [gaugeFun] using h2.cexp

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
lemma contDiff_gaugePhase (b m : V) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (gaugePhase b m) := by
  unfold gaugePhase
  have h1 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (fun x : V => (inner ℝ x b : ℝ)) :=
    ((innerSL ℝ).flip b).contDiff
  have h2 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (fun x : V => (inner ℝ x m : ℝ)) :=
    ((innerSL ℝ).flip m).contDiff
  exact ((h1.neg.mul h2).div_const _).add ((contDiff_const.mul (h2.pow 2)).div_const _)

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
lemma contDiff_gaugeFun (b m : V) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (gaugeFun b m) := by
  unfold gaugeFun
  exact ((Complex.contDiff_exp (𝕜 := ℂ)).restrict_scalars ℝ).comp
    (contDiff_const.mul (Complex.ofRealCLM.contDiff.comp (contDiff_gaugePhase b m)))

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
/-- The gauge factor is unimodular. -/
lemma norm_gaugeFun (b m : V) (x : V) : ‖gaugeFun b m x‖ = 1 := by
  rw [gaugeFun, mul_comm]
  exact Complex.norm_exp_ofReal_mul_I _

/-- The gauged test function `e^{iθ}φ`: still smooth and compactly supported, hence still a
Schwartz function.  (Multiplication by `e^{iθ}` is *not* claimed to preserve Schwartz space
in general.) -/
noncomputable def gaugeSchwartz (b m : V) (φ : 𝓢(V, ℂ))
    (hφ : HasCompactSupport (φ : V → ℂ)) : 𝓢(V, ℂ) :=
  (hφ.mul_left (f := gaugeFun b m)).toSchwartzMap
    ((contDiff_gaugeFun b m).mul (φ.smooth ⊤))

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
@[simp] lemma gaugeSchwartz_apply (b m : V) (φ : 𝓢(V, ℂ))
    (hφ : HasCompactSupport (φ : V → ℂ)) (x : V) :
    gaugeSchwartz b m φ hφ x = gaugeFun b m x * φ x := rfl

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
/-- **The gauge intertwines the mixed operator with the momentum operator**:
`(⟪·,b⟫ − i∂_m)(e^{iθ}φ) = e^{iθ}(−i∂_m φ)`. -/
lemma mixedLinearOp_gauge (b m : V) (hm : m ≠ 0) (φ : 𝓢(V, ℂ))
    (hφ : HasCompactSupport (φ : V → ℂ)) (x : V) :
    (mixedLinearOp b m (gaugeSchwartz b m φ hφ)) x
      = gaugeFun b m x * (momentumOp m φ x) := by
  have hφd : HasDerivAt (fun t : ℝ => φ (x + t • m)) (fderiv ℝ (φ : V → ℂ) x m) 0 :=
    (φ.differentiableAt).hasFDerivAt.hasLineDerivAt m
  have hνd := hasDerivAt_gaugeFun_line b m hm x
  have hprod : HasDerivAt (fun t : ℝ => gaugeFun b m (x + t • m) * φ (x + t • m))
      ((gaugeFun b m x * (Complex.I * ((-(inner ℝ x b : ℝ) : ℝ) : ℂ))) * φ x
        + gaugeFun b m x * fderiv ℝ (φ : V → ℂ) x m) 0 := by
    simpa using hνd.mul hφd
  have hgd : HasDerivAt (fun t : ℝ => (gaugeSchwartz b m φ hφ) (x + t • m))
      (fderiv ℝ ((gaugeSchwartz b m φ hφ) : V → ℂ) x m) 0 :=
    ((gaugeSchwartz b m φ hφ).differentiableAt).hasFDerivAt.hasLineDerivAt m
  have hval := hgd.unique hprod
  rw [mixedLinearOp_apply, hval, momentumOp_apply, gaugeSchwartz_apply]
  push_cast
  linear_combination ((inner ℝ x b : ℝ) : ℂ) * gaugeFun b m x * φ x * Complex.I_mul_I

/-! ## 5. Essential self-adjointness of the mixed operator -/

/-- **The mixed operator has trivial deficiency spaces** at every non-real point. -/
theorem mixedLinearOp_deficiencyTrivialAt (b m : V) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (schwartzDomain V) (opL2 (mixedLinearOp b m)) z := by
  rcases eq_or_ne m 0 with rfl | hm
  · have h0 : mixedLinearOp b (0 : V) = posOp b := by
      have h : momentumOp (0 : V) = 0 := by
        ext f x
        simp [momentumOp_apply]
      rw [mixedLinearOp, h, add_zero]
    rw [h0]
    exact posOp_deficiencyTrivialAt b hz
  intro u hu
  have hmem : MemLp (fun x => (starRingEnd ℂ) (gaugeFun b m x) * (u x)) 2
      (volume : Measure V) := by
    have hmeas : AEStronglyMeasurable (fun x => (starRingEnd ℂ) (gaugeFun b m x) * (u x))
        (volume : Measure V) :=
      (Complex.continuous_conj.comp ((contDiff_gaugeFun b m).continuous)).aestronglyMeasurable.mul
        (Lp.aestronglyMeasurable u)
    refine (Lp.memLp u).of_le hmeas (Filter.Eventually.of_forall fun x => ?_)
    simp [norm_gaugeFun]
  set w : Lp ℂ 2 (volume : Measure V) := hmem.toLp _ with hwdef
  have hwcoe : ∀ᵐ x ∂(volume : Measure V),
      (w x : ℂ) = (starRingEnd ℂ) (gaugeFun b m x) * (u x) := hmem.coeFn_toLp
  have hw : ∀ φ : 𝓢(V, ℂ), HasCompactSupport (φ : V → ℂ) →
      ∫ x, (starRingEnd ℂ) ((momentumOp m φ) x) * (w x)
        = z * ∫ x, (starRingEnd ℂ) (φ x) * (w x) := by
    intro φ hφ
    have h1 := hu (schwartzEquiv V (gaugeSchwartz b m φ hφ))
    rw [opL2_apply, schwartzEquiv_coe, inner_toLp_left, inner_toLp_left] at h1
    have hL : ∫ x, (starRingEnd ℂ) ((momentumOp m φ) x) * (w x)
        = ∫ x, (starRingEnd ℂ) ((mixedLinearOp b m (gaugeSchwartz b m φ hφ)) x) * (u x) := by
      refine integral_congr_ae ?_
      filter_upwards [hwcoe] with x hx
      rw [hx, mixedLinearOp_gauge b m hm φ hφ x, map_mul]
      ring
    have hR : ∫ x, (starRingEnd ℂ) (φ x) * (w x)
        = ∫ x, (starRingEnd ℂ) ((gaugeSchwartz b m φ hφ) x) * (u x) := by
      refine integral_congr_ae ?_
      filter_upwards [hwcoe] with x hx
      rw [hx, gaugeSchwartz_apply, map_mul]
      ring
    rw [hL, hR, h1]
  have hw0 : w = 0 := momentumOp_eq_zero_of_compactSupport_test m hz w hw
  have hae : ∀ᵐ x ∂(volume : Measure V), (u x : ℂ) = 0 := by
    have h0 : ∀ᵐ x ∂(volume : Measure V), (w x : ℂ) = 0 := by
      rw [hw0]
      exact Lp.coeFn_zero ℂ 2 (volume : Measure V)
    filter_upwards [hwcoe, h0] with x hx hx0
    rw [hx] at hx0
    rcases mul_eq_zero.mp hx0 with h | h
    · have hn : ‖(starRingEnd ℂ) (gaugeFun b m x)‖ = 1 := by
        rw [RCLike.norm_conj]
        exact norm_gaugeFun b m x
      rw [h, norm_zero] at hn
      exact absurd hn (by norm_num)
    · exact h
  exact Lp.eq_zero_iff_ae_eq_zero.mpr hae

/-- **The headline.**  For arbitrary `b, m ∈ V` the mixed first-order operator
`⟪x, b⟫ − i ∂_m` is essentially self-adjoint on the Schwartz core of `L²(V)`. -/
theorem mixedLinearOp_essentiallySelfAdjoint (b m : V) :
    EssentiallySelfAdjointOn (schwartzDomain V) (opL2 (mixedLinearOp b m)) :=
  ⟨mixedLinearOp_deficiencyTrivialAt b m (by simp),
    mixedLinearOp_deficiencyTrivialAt b m (by simp)⟩

/-! ## 6. An arbitrary potential with a gauge along `m`

The gauge argument never uses that the potential is *linear*: it uses only that the phase
`θ` solves the transport equation `∂_m θ = −W` along the momentum direction.  Written that
way it is an instrument, and it covers unbounded polynomial potentials — for instance the
quartic `x⁴ − i d/dx` on `L²(ℝ)`, which is neither a Fourier multiplier nor an operator
with an `L²` eigenvector. -/

/-- The operator `W(x) − i ∂_m`: an arbitrary real potential of temperate growth plus a
momentum term. -/
noncomputable def potMomOp (W : V → ℝ) (m : V) : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ) :=
  potentialOp W + momentumOp m

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
lemma potMomOp_apply {W : V → ℝ} (hW : Function.HasTemperateGrowth W) (m : V) (f : 𝓢(V, ℂ))
    (x : V) :
    (potMomOp W m f) x = ((W x : ℝ) : ℂ) * f x + (-Complex.I) * (fderiv ℝ f x m) := by
  simp [potMomOp, potentialOp_apply hW, momentumOp_apply]

/-- `W(x) − i ∂_m` is symmetric on the Schwartz core. -/
theorem potMomOp_symmetric (W : V → ℝ) (hW : Function.HasTemperateGrowth W) (m : V) :
    SymmetricOn (schwartzDomain V) (opL2 (potMomOp W m)) := by
  have hmom : SymmetricOn (schwartzDomain V) (opL2 (momentumOp m)) :=
    symmetricOn_of_real_symbol (momentumOp m) (fun x => 2 * Real.pi * (inner ℝ x m))
      (fun f x => by simpa using fourier_momentumOp_apply f m x)
  rw [potMomOp, opL2_add]
  intro x y
  simp only [LinearMap.add_apply, inner_add_left, inner_add_right,
    potentialOp_symmetric W hW x y, hmom x y]

/-- The unimodular gauge factor `e^{iθ}` of an arbitrary real phase. -/
noncomputable def phaseFun (θ : V → ℝ) (x : V) : ℂ :=
  Complex.exp (Complex.I * ((θ x : ℝ) : ℂ))

omit [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V] in
@[simp] lemma norm_phaseFun (θ : V → ℝ) (x : V) : ‖phaseFun θ x‖ = 1 := by
  rw [phaseFun, mul_comm]
  exact Complex.norm_exp_ofReal_mul_I _

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
lemma contDiff_phaseFun {θ : V → ℝ} (hθ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) θ) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (phaseFun θ) := by
  unfold phaseFun
  exact ((Complex.contDiff_exp (𝕜 := ℂ)).restrict_scalars ℝ).comp
    (contDiff_const.mul (Complex.ofRealCLM.contDiff.comp hθ))

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
/-- If `θ` has directional derivative `−W(x)` along `m`, the gauge factor has directional
derivative `−i W(x) e^{iθ}`. -/
lemma hasDerivAt_phaseFun_line {W θ : V → ℝ} {m : V}
    (hθd : ∀ x, HasDerivAt (fun t : ℝ => θ (x + t • m)) (-(W x)) 0) (x : V) :
    HasDerivAt (fun t : ℝ => phaseFun θ (x + t • m))
      (phaseFun θ x * (Complex.I * ((-(W x) : ℝ) : ℂ))) 0 := by
  have h1 : HasDerivAt (fun t : ℝ => ((θ (x + t • m) : ℝ) : ℂ)) (((-(W x) : ℝ) : ℂ)) 0 :=
    (hθd x).ofReal_comp
  have h2 : HasDerivAt (fun t : ℝ => Complex.I * ((θ (x + t • m) : ℝ) : ℂ))
      (Complex.I * ((-(W x) : ℝ) : ℂ)) 0 := h1.const_mul _
  simpa [phaseFun] using h2.cexp

/-- The gauged test function `e^{iθ}φ`, still smooth and compactly supported. -/
noncomputable def phaseSchwartz {θ : V → ℝ} (hθ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) θ)
    (φ : 𝓢(V, ℂ)) (hφ : HasCompactSupport (φ : V → ℂ)) : 𝓢(V, ℂ) :=
  (hφ.mul_left (f := phaseFun θ)).toSchwartzMap ((contDiff_phaseFun hθ).mul (φ.smooth ⊤))

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
@[simp] lemma phaseSchwartz_apply {θ : V → ℝ} (hθ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) θ)
    (φ : 𝓢(V, ℂ)) (hφ : HasCompactSupport (φ : V → ℂ)) (x : V) :
    phaseSchwartz hθ φ hφ x = phaseFun θ x * φ x := rfl

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
/-- **The gauge intertwines `W(x) − i ∂_m` with the momentum operator** as soon as the phase
solves the transport equation `∂_m θ = −W`. -/
lemma potMomOp_gauge {W θ : V → ℝ} (hW : Function.HasTemperateGrowth W) {m : V}
    (hθ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) θ)
    (hθd : ∀ x, HasDerivAt (fun t : ℝ => θ (x + t • m)) (-(W x)) 0)
    (φ : 𝓢(V, ℂ)) (hφ : HasCompactSupport (φ : V → ℂ)) (x : V) :
    (potMomOp W m (phaseSchwartz hθ φ hφ)) x = phaseFun θ x * (momentumOp m φ x) := by
  have hφd : HasDerivAt (fun t : ℝ => φ (x + t • m)) (fderiv ℝ (φ : V → ℂ) x m) 0 :=
    (φ.differentiableAt).hasFDerivAt.hasLineDerivAt m
  have hνd := hasDerivAt_phaseFun_line hθd x
  have hprod : HasDerivAt (fun t : ℝ => phaseFun θ (x + t • m) * φ (x + t • m))
      ((phaseFun θ x * (Complex.I * ((-(W x) : ℝ) : ℂ))) * φ x
        + phaseFun θ x * fderiv ℝ (φ : V → ℂ) x m) 0 := by
    simpa using hνd.mul hφd
  have hgd : HasDerivAt (fun t : ℝ => (phaseSchwartz hθ φ hφ) (x + t • m))
      (fderiv ℝ ((phaseSchwartz hθ φ hφ) : V → ℂ) x m) 0 :=
    ((phaseSchwartz hθ φ hφ).differentiableAt).hasFDerivAt.hasLineDerivAt m
  have hval := hgd.unique hprod
  rw [potMomOp_apply hW, hval, momentumOp_apply, phaseSchwartz_apply]
  push_cast
  linear_combination ((W x : ℝ) : ℂ) * phaseFun θ x * φ x * Complex.I_mul_I

/-- **Vanishing deficiency spaces for `W(x) − i ∂_m`** under the transport hypothesis. -/
theorem potMomOp_deficiencyTrivialAt {W θ : V → ℝ} (hW : Function.HasTemperateGrowth W)
    {m : V} (hθ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) θ)
    (hθd : ∀ x, HasDerivAt (fun t : ℝ => θ (x + t • m)) (-(W x)) 0)
    {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (schwartzDomain V) (opL2 (potMomOp W m)) z := by
  intro u hu
  have hmem : MemLp (fun x => (starRingEnd ℂ) (phaseFun θ x) * (u x)) 2
      (volume : Measure V) := by
    have hmeas : AEStronglyMeasurable (fun x => (starRingEnd ℂ) (phaseFun θ x) * (u x))
        (volume : Measure V) :=
      (Complex.continuous_conj.comp ((contDiff_phaseFun hθ).continuous)).aestronglyMeasurable.mul
        (Lp.aestronglyMeasurable u)
    refine (Lp.memLp u).of_le hmeas (Filter.Eventually.of_forall fun x => ?_)
    simp
  set w : Lp ℂ 2 (volume : Measure V) := hmem.toLp _ with hwdef
  have hwcoe : ∀ᵐ x ∂(volume : Measure V),
      (w x : ℂ) = (starRingEnd ℂ) (phaseFun θ x) * (u x) := hmem.coeFn_toLp
  have hw : ∀ φ : 𝓢(V, ℂ), HasCompactSupport (φ : V → ℂ) →
      ∫ x, (starRingEnd ℂ) ((momentumOp m φ) x) * (w x)
        = z * ∫ x, (starRingEnd ℂ) (φ x) * (w x) := by
    intro φ hφ
    have h1 := hu (schwartzEquiv V (phaseSchwartz hθ φ hφ))
    rw [opL2_apply, schwartzEquiv_coe, inner_toLp_left, inner_toLp_left] at h1
    have hL : ∫ x, (starRingEnd ℂ) ((momentumOp m φ) x) * (w x)
        = ∫ x, (starRingEnd ℂ) ((potMomOp W m (phaseSchwartz hθ φ hφ)) x) * (u x) := by
      refine integral_congr_ae ?_
      filter_upwards [hwcoe] with x hx
      rw [hx, potMomOp_gauge hW hθ hθd φ hφ x, map_mul]
      ring
    have hR : ∫ x, (starRingEnd ℂ) (φ x) * (w x)
        = ∫ x, (starRingEnd ℂ) ((phaseSchwartz hθ φ hφ) x) * (u x) := by
      refine integral_congr_ae ?_
      filter_upwards [hwcoe] with x hx
      rw [hx, phaseSchwartz_apply, map_mul]
      ring
    rw [hL, hR, h1]
  have hw0 : w = 0 := momentumOp_eq_zero_of_compactSupport_test m hz w hw
  have hae : ∀ᵐ x ∂(volume : Measure V), (u x : ℂ) = 0 := by
    have h0 : ∀ᵐ x ∂(volume : Measure V), (w x : ℂ) = 0 := by
      rw [hw0]
      exact Lp.coeFn_zero ℂ 2 (volume : Measure V)
    filter_upwards [hwcoe, h0] with x hx hx0
    rw [hx] at hx0
    rcases mul_eq_zero.mp hx0 with h | h
    · have hn : ‖(starRingEnd ℂ) (phaseFun θ x)‖ = 1 := by
        rw [RCLike.norm_conj]
        exact norm_phaseFun θ x
      rw [h, norm_zero] at hn
      exact absurd hn (by norm_num)
    · exact h
  exact Lp.eq_zero_iff_ae_eq_zero.mpr hae

/-- **The instrument.**  If the real potential `W` has temperate growth and admits a smooth
phase `θ` with `∂_m θ = −W` along the momentum direction, then `W(x) − i ∂_m` is essentially
self-adjoint on the Schwartz core of `L²(V)`. -/
theorem potMomOp_essentiallySelfAdjoint {W θ : V → ℝ} (hW : Function.HasTemperateGrowth W)
    {m : V} (hθ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) θ)
    (hθd : ∀ x, HasDerivAt (fun t : ℝ => θ (x + t • m)) (-(W x)) 0) :
    EssentiallySelfAdjointOn (schwartzDomain V) (opL2 (potMomOp W m)) :=
  ⟨potMomOp_deficiencyTrivialAt hW hθ hθd (by simp),
    potMomOp_deficiencyTrivialAt hW hθ hθd (by simp)⟩

/-! ## 7. Polynomial potentials along the momentum direction -/

/-- The polynomial potential `W(x) = ∑_{i<n} cᵢ ⟪x, m⟫ⁱ` in the momentum direction. -/
noncomputable def polyPotential (c : ℕ → ℝ) (n : ℕ) (m : V) (x : V) : ℝ :=
  ∑ i ∈ Finset.range n, c i * (inner ℝ x m : ℝ) ^ i

/-- Its transport phase `θ(x) = −∑_{i<n} cᵢ ⟪x,m⟫^{i+1}/((i+1)‖m‖²)`. -/
noncomputable def polyPhase (c : ℕ → ℝ) (n : ℕ) (m : V) (x : V) : ℝ :=
  ∑ i ∈ Finset.range n, -(c i * (inner ℝ x m : ℝ) ^ (i + 1) / ((i + 1) * ‖m‖ ^ 2))

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
lemma hasTemperateGrowth_polyPotential (c : ℕ → ℝ) (n : ℕ) (m : V) :
    Function.HasTemperateGrowth (polyPotential c n m) := by
  unfold polyPotential
  refine Function.HasTemperateGrowth.sum fun i _ => ?_
  simpa using (Function.HasTemperateGrowth.const (c i)).mul
    ((Function.hasTemperateGrowth_inner_left m).pow i)

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
lemma contDiff_polyPhase (c : ℕ → ℝ) (n : ℕ) (m : V) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (polyPhase c n m) := by
  unfold polyPhase
  refine ContDiff.sum fun i _ => ?_
  have h : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (fun x : V => (inner ℝ x m : ℝ)) :=
    ((innerSL ℝ).flip m).contDiff
  exact (((contDiff_const.mul (h.pow (i + 1))).div_const _)).neg

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
/-- The transport equation `∂_m θ = −W` for the polynomial potential. -/
lemma hasDerivAt_polyPhase_line (c : ℕ → ℝ) (n : ℕ) {m : V} (hm : m ≠ 0) (x : V) :
    HasDerivAt (fun t : ℝ => polyPhase c n m (x + t • m)) (-(polyPotential c n m x)) 0 := by
  have hD0 : (‖m‖ : ℝ) ^ 2 ≠ 0 := by positivity
  have hline : ∀ t : ℝ, (inner ℝ (x + t • m) m : ℝ) = (inner ℝ x m : ℝ) + t * ‖m‖ ^ 2 := by
    intro t
    rw [inner_add_left, real_inner_smul_left, real_inner_self_eq_norm_sq]
  have hfun : (fun t : ℝ => polyPhase c n m (x + t • m))
      = fun t : ℝ => ∑ i ∈ Finset.range n,
          -(c i * ((inner ℝ x m : ℝ) + t * ‖m‖ ^ 2) ^ (i + 1) / ((i + 1) * ‖m‖ ^ 2)) := by
    funext t
    unfold polyPhase
    exact Finset.sum_congr rfl fun i _ => by rw [hline t]
  rw [hfun]
  have hbase : HasDerivAt (fun t : ℝ => (inner ℝ x m : ℝ) + t * ‖m‖ ^ 2) (‖m‖ ^ 2) 0 := by
    simpa using ((hasDerivAt_id (0 : ℝ)).mul_const (‖m‖ ^ 2)).const_add (inner ℝ x m : ℝ)
  have hterm : ∀ i ∈ Finset.range n,
      HasDerivAt (fun t : ℝ => -(c i * ((inner ℝ x m : ℝ) + t * ‖m‖ ^ 2) ^ (i + 1)
        / ((i + 1) * ‖m‖ ^ 2))) (-(c i * (inner ℝ x m : ℝ) ^ i)) 0 := by
    intro i _
    have h1 : HasDerivAt (fun t : ℝ => ((inner ℝ x m : ℝ) + t * ‖m‖ ^ 2) ^ (i + 1))
        (((i : ℝ) + 1) * ((inner ℝ x m : ℝ)) ^ i * ‖m‖ ^ 2) 0 := by
      simpa using hbase.pow (i + 1)
    have h2 := ((h1.const_mul (c i)).div_const (((i : ℝ) + 1) * ‖m‖ ^ 2)).neg
    convert h2 using 1
    have hi0 : ((i : ℝ) + 1) ≠ 0 := by positivity
    field_simp
  have hsum := HasDerivAt.sum hterm
  have hfe : (∑ i ∈ Finset.range n, fun t : ℝ =>
        -(c i * ((inner ℝ x m : ℝ) + t * ‖m‖ ^ 2) ^ (i + 1) / (((i : ℝ) + 1) * ‖m‖ ^ 2)))
      = fun t : ℝ => ∑ i ∈ Finset.range n,
        -(c i * ((inner ℝ x m : ℝ) + t * ‖m‖ ^ 2) ^ (i + 1) / (((i : ℝ) + 1) * ‖m‖ ^ 2)) :=
    funext fun t => by simp
  rw [hfe] at hsum
  convert hsum using 1
  simp [polyPotential]

/-- **A polynomial potential in the momentum direction plus the momentum operator.**  For
arbitrary real coefficients `c`, degree bound `n` and direction `m ≠ 0`, the operator
`∑_{i<n} cᵢ ⟪x, m⟫ⁱ − i ∂_m` is symmetric and essentially self-adjoint on the Schwartz core
of `L²(V)`.  With `V = ℝ`, `m = 1`, `c₄ = 1` this is the quartic operator
`x⁴ − i d/dx`: the potential is unbounded, has no `L²` eigenvector and is not a Fourier
multiplier. -/
theorem polyPotential_add_momentum_essentiallySelfAdjoint (c : ℕ → ℝ) (n : ℕ) {m : V}
    (hm : m ≠ 0) :
    EssentiallySelfAdjointOn (schwartzDomain V) (opL2 (potMomOp (polyPotential c n m) m)) :=
  potMomOp_essentiallySelfAdjoint (hasTemperateGrowth_polyPotential c n m)
    (contDiff_polyPhase c n m) (hasDerivAt_polyPhase_line c n hm)

/-- The same operator is symmetric on the Schwartz core. -/
theorem polyPotential_add_momentum_symmetric (c : ℕ → ℝ) (n : ℕ) (m : V) :
    SymmetricOn (schwartzDomain V) (opL2 (potMomOp (polyPotential c n m) m)) :=
  potMomOp_symmetric _ (hasTemperateGrowth_polyPotential c n m) m

end BookProof.MixedLinearEsa
