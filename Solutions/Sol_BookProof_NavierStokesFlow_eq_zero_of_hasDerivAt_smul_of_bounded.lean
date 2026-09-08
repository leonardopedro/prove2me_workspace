-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.eq_zero_of_hasDerivAt_smul_of_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.NavierStokesFlow









open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (g : ℝ → ℂ) (s C : ℝ) (hs : s * s = 1)
    (hgd : ∀ t : ℝ, HasDerivAt g ((s : ℂ) * g t) t) (hb : ∀ t : ℝ, ‖g t‖ ≤ C) : g 0 = 0 := by

  set h : ℝ → ℂ := fun t => Real.exp (-(s * t)) • g t with hh
  have hhd : ∀ t : ℝ, HasDerivAt h 0 t := by
    intro t
    have h1 : HasDerivAt (fun t : ℝ => Real.exp (-(s * t))) (-s * Real.exp (-(s * t))) t := by
      have hlin : HasDerivAt (fun t : ℝ => -(s * t)) (-s) t := by
        simpa using ((hasDerivAt_id t).const_mul s).neg
      simpa [mul_comm] using hlin.exp
    have h2 := h1.smul (hgd t)
    have heq : Real.exp (-(s * t)) • ((s : ℂ) * g t) + (-s * Real.exp (-(s * t))) • g t = 0 := by
      push_cast [Complex.real_smul]
      ring
    rw [heq] at h2
    exact h2
  have hconst : ∀ t : ℝ, h t = h 0 := fun t =>
    is_const_of_deriv_eq_zero (fun x => (hhd x).differentiableAt) (fun x => (hhd x).deriv) t 0
  have hb0 : ∀ T : ℝ, ‖g 0‖ ≤ Real.exp (-T) * C := by
    intro T
    have hst : s * (s * T) = T := by rw [← mul_assoc, hs, one_mul]
    have h3 := hconst (s * T)
    simp only [hh, hst, mul_zero, neg_zero, Real.exp_zero, one_smul] at h3
    rw [← h3, norm_smul]
    simp only [Real.norm_eq_abs, abs_of_pos (Real.exp_pos _)]
    exact mul_le_mul_of_nonneg_left (hb _) (Real.exp_pos _).le
  have htend : Filter.Tendsto (fun T : ℝ => Real.exp (-T) * C) Filter.atTop (nhds 0) := by
    simpa using Real.tendsto_exp_neg_atTop_nhds_zero.mul_const C
  have hle : ‖g 0‖ ≤ 0 := ge_of_tendsto htend (Filter.Eventually.of_forall hb0)
  simpa using le_antisymm hle (norm_nonneg _)
