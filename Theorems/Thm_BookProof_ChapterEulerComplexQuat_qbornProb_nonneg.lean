-- Generated from ChapterEulerComplexQuat.lean — theorem BookProof.ChapterEulerComplexQuat.qbornProb_nonneg
import Mathlib
import Definitions.Def_ChapterEulerComplexQuat
open BookProof.ChapterEulerComplexQuat


open scoped Quaternion BigOperators


variable {n : ℕ}


theorem BookProof.ChapterEulerComplexQuat.qbornProb_nonneg (v : Fin n → ℍ[ℝ]) (k : Fin n) : 0 ≤ qbornProb v k := by sorry
