-- Generated from ChapterEulerComplexQuat.lean — solution of BookProof.ChapterEulerComplexQuat.cbornProb_nonneg
import Mathlib
import Definitions.Def_ChapterEulerComplexQuat
open BookProof.ChapterEulerComplexQuat



open scoped Quaternion BigOperators


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin n → ℂ) (k : Fin n) : 0 ≤ cbornProb v k := Complex.normSq_nonneg _
