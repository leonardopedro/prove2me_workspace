-- Generated from ChapterEulerComplexQuat.lean — solution of BookProof.ChapterEulerComplexQuat.quat_realification_norm
import Mathlib
import Definitions.Def_ChapterEulerComplexQuat
import Theorems.Thm_BookProof_ChapterEulerComplexQuat_quat_born_split
open BookProof.ChapterEulerComplexQuat



open scoped Quaternion BigOperators


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin n → ℍ[ℝ]) :
    ∑ k, ((v k).re ^ 2 + (v k).imI ^ 2 + (v k).imJ ^ 2 + (v k).imK ^ 2)
      = ∑ k, qbornProb v k := by

  refine Finset.sum_congr rfl (fun k _ => ?_)
  rw [quat_born_split]
