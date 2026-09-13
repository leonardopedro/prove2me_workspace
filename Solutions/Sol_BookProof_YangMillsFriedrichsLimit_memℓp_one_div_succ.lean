-- Generated from ChapterYangMillsFriedrichsLimit.lean — solution of BookProof.YangMillsFriedrichsLimit.memℓp_one_div_succ
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
open BookProof.YangMillsFriedrichsLimit









open BookProof.FarisLavine BookProof.YangMillsFriedrichs



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]











open scoped InnerProductSpace ENNReal

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solutionℓp_one_div_succ : Memℓp (fun n : ℕ => (1 / (n + 1) : ℂ)) 2 := by

  rw [memℓp_gen_iff (by norm_num : (0 : ℝ) < (2 : ℝ≥0∞).toReal)]
  have hcong : ∀ n : ℕ, ‖(1 / (n + 1) : ℂ)‖ ^ (2 : ℝ≥0∞).toReal = (1 / ((n : ℝ) + 1)) ^ 2 := by
    intro n
    have hn : ‖(1 / (n + 1) : ℂ)‖ = 1 / ((n : ℝ) + 1) := by
      rw [norm_div]
      congr 1
      · simp
      · rw [show ((n : ℂ) + 1) = ((((n : ℝ) + 1) : ℝ) : ℂ) by push_cast; ring, Complex.norm_real,
          Real.norm_eq_abs, abs_of_nonneg (by positivity)]
    rw [hn]
    norm_num
  rw [summable_congr hcong]
  have hs := Real.summable_one_div_nat_pow (p := 2) |>.mpr (by norm_num)
  refine ((summable_nat_add_iff 1).mpr hs).congr (fun n => ?_)
  push_cast
  rw [div_pow]
  norm_num
