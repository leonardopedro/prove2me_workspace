-- Generated from ChapterNumericalRangeCrouzeix.lean — solution of BookProof.ChapterNumericalRangeCrouzeix.norm_pow_le_of_numRadiusLE
import Mathlib
import Definitions.Def_ChapterNumericalRangeCrouzeix
import Theorems.Thm_BookProof_ChapterNumericalRangeCrouzeix_numRadiusLE_pow
import Theorems.Thm_BookProof_ChapterNumericalRangeCrouzeix_norm_le_two_mul_of_numRadiusLE
open BookProof.ChapterNumericalRangeCrouzeix



open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {A : E →L[ℂ] E} {r : ℝ} (hr : 0 ≤ r)
    (h : NumRadiusLE A r) (n : ℕ) (hn : 0 < n) : ‖A ^ n‖ ≤ 2 * r ^ n := norm_le_two_mul_of_numRadiusLE (by positivity) (numRadiusLE_pow hr h n hn)
