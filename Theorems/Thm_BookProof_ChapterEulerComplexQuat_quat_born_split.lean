-- Generated from ChapterEulerComplexQuat.lean — theorem BookProof.ChapterEulerComplexQuat.quat_born_split
import Mathlib
import Definitions.Def_ChapterEulerComplexQuat
open BookProof.ChapterEulerComplexQuat

variable {n : ℕ}


open scoped Quaternion BigOperators



theorem BookProof.ChapterEulerComplexQuat.quat_born_split (v : Fin n → ℍ[ℝ]) (k : Fin n) :
    qbornProb v k =
      (v k).re ^ 2 + (v k).imI ^ 2 + (v k).imJ ^ 2 + (v k).imK ^ 2 := by sorry
