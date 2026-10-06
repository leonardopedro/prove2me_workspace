-- Generated from ChapterEulerComplexQuat.lean — solution of BookProof.ChapterEulerComplexQuat.complex_realification_norm
import Mathlib
import Definitions.Def_ChapterEulerComplexQuat
import Theorems.Thm_BookProof_ChapterEulerComplexQuat_complex_born_split
open BookProof.ChapterEulerComplexQuat



open scoped Quaternion BigOperators


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin n → ℂ) :
    ∑ k, ((v k).re ^ 2 + (v k).im ^ 2) = ∑ k, cbornProb v k := by

  refine Finset.sum_congr rfl (fun k _ => ?_)
  rw [complex_born_split]
