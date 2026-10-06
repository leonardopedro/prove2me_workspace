-- Generated from ChapterEulerComplexQuat.lean — solution of BookProof.ChapterEulerComplexQuat.complex_born_split
import Mathlib
import Definitions.Def_ChapterEulerComplexQuat
open BookProof.ChapterEulerComplexQuat



open scoped Quaternion BigOperators


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin n → ℂ) (k : Fin n) :
    cbornProb v k = (v k).re ^ 2 + (v k).im ^ 2 := by

  simp [cbornProb, Complex.normSq_apply]; ring
