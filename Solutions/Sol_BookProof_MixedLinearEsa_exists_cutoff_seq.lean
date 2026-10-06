-- Generated from ChapterMixedLinearEsa.lean — solution of BookProof.MixedLinearEsa.exists_cutoff_seq
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
open BookProof.MixedLinearEsa




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in
theorem solution :
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
