-- Generated from ChapterUnboundedPosition.lean — solution of BookProof.ChapterUnboundedPosition.tendsto_phaseUnitary
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterUnboundedPosition



open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

set_option maxHeartbeats 1000000 in
theorem solution (f : ℤ → ℝ) (psi : L2Z) :
    Filter.Tendsto (fun t : ℝ => phaseUnitary f t psi) (nhds 0) (nhds psi) :=
  → ℝ) (psi : L2Z) :
      Filter.Tendsto (fun t : ℝ => phaseUnitary f t psi) (nhds 0) (nhds psi) := by
    rw [tendsto_iff_norm_sub_tendsto_zero]
    have hsq : ∀ t : ℝ, ‖phaseUnitary f t psi - psi‖ ^ 2
        = ∑' k : ℤ, ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2 := by
      intro t
      rw [BookProof.ChapterContinuityUnitaryInfinite.norm_sq_eq_tsum]
      refine tsum_congr fun k => ?_
      congr 1
      simp [sub_mul]
    have hbound : Summable fun k : ℤ => 4 * ‖(psi : ℤ → ℂ) k‖ ^ 2 :=
      (BookProof.ChapterContinuityUnitaryInfinite.summable_normSq psi).mul_left 4
    have hpt : ∀ k : ℤ, Filter.Tendsto
        (fun t : ℝ => ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2) (nhds 0) (nhds 0) := by
      intro k
      have hc : Continuous fun t : ℝ => ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2 :=
        (((continuous_phase f k).sub continuous_const).mul continuous_const).norm.pow 2
      simpa [phase] using hc.tendsto 0
    have hdom : ∀ t : ℝ, ∀ k : ℤ,
        ‖‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2‖ ≤ 4 * ‖(psi : ℤ → ℂ) k‖ ^ 2 := by
      intro t k
      have h1 : ‖phase f t k - 1‖ ≤ 2 := by
        calc ‖phase f t k - 1‖ ≤ ‖phase f t k‖ + ‖(1 : ℂ)‖ := norm_sub_le _ _
          _ = 2 := by rw [norm_phase]; norm_num
      have h2 : ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ≤ 2 * ‖(psi : ℤ → ℂ) k‖ := by
        rw [norm_mul]
        exact mul_le_mul_of_nonneg_right h1 (norm_nonneg _)
      rw [Real.norm_eq_abs, abs_of_nonneg (by positivity)]
      nlinarith [norm_nonneg ((phase f t k - 1) * (psi : ℤ → ℂ) k), norm_nonneg ((psi : ℤ → ℂ) k)]
    have htsum := tendsto_tsum_of_dominated_convergence hbound hpt
      (Filter.Eventually.of_forall hdom)
    rw [tsum_zero] at htsum
    have hsqrt : Filter.Tendsto
        (fun t : ℝ => Real.sqrt (∑' k : ℤ, ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2))
        (nhds 0) (nhds 0) := by
      simpa using! (Real.continuous_sqrt.t
