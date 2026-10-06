-- Generated from ChapterEulerComplexQuat.lean — theorem BookProof.ChapterEulerComplexQuat.complex_born_split
import Mathlib
import Definitions.Def_ChapterEulerComplexQuat
open BookProof.ChapterEulerComplexQuat

variable {n : ℕ}


open scoped Quaternion BigOperators



theorem BookProof.ChapterEulerComplexQuat.complex_born_split (v : Fin n → ℂ) (k : Fin n) :
    cbornProb v k = (v k).re ^ 2 + (v k).im ^ 2 := by sorry
