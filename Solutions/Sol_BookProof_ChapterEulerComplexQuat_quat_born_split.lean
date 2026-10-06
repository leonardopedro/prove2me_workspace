-- Generated from ChapterEulerComplexQuat.lean — solution of BookProof.ChapterEulerComplexQuat.quat_born_split
import Mathlib
import Definitions.Def_ChapterEulerComplexQuat
open BookProof.ChapterEulerComplexQuat



open scoped Quaternion BigOperators


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin n → ℍ[ℝ]) (k : Fin n) :
    qbornProb v k =
      (v k).re ^ 2 + (v k).imI ^ 2 + (v k).imJ ^ 2 + (v k).imK ^ 2 := by

  simp [qbornProb, Quaternion.normSq_def']
