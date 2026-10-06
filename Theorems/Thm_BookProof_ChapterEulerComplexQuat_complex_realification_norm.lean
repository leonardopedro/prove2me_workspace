-- Generated from ChapterEulerComplexQuat.lean — theorem BookProof.ChapterEulerComplexQuat.complex_realification_norm
import Mathlib
import Definitions.Def_ChapterEulerComplexQuat
open BookProof.ChapterEulerComplexQuat

variable {n : ℕ}


open scoped Quaternion BigOperators



theorem BookProof.ChapterEulerComplexQuat.complex_realification_norm (v : Fin n → ℂ) :
    ∑ k, ((v k).re ^ 2 + (v k).im ^ 2) = ∑ k, cbornProb v k := by sorry
