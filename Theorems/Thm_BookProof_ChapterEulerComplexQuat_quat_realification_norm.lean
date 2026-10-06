-- Generated from ChapterEulerComplexQuat.lean — theorem BookProof.ChapterEulerComplexQuat.quat_realification_norm
import Mathlib
import Definitions.Def_ChapterEulerComplexQuat
open BookProof.ChapterEulerComplexQuat

variable {n : ℕ}


open scoped Quaternion BigOperators



theorem BookProof.ChapterEulerComplexQuat.quat_realification_norm (v : Fin n → ℍ[ℝ]) :
    ∑ k, ((v k).re ^ 2 + (v k).imI ^ 2 + (v k).imJ ^ 2 + (v k).imK ^ 2)
      = ∑ k, qbornProb v k := by sorry
