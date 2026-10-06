-- Generated from ChapterEulerComplexQuat.lean — theorem BookProof.ChapterEulerComplexQuat.quat_reproduces
import Mathlib
import Definitions.Def_ChapterEulerComplexQuat
open BookProof.ChapterEulerComplexQuat

variable {n : ℕ}


open scoped Quaternion BigOperators



theorem BookProof.ChapterEulerComplexQuat.quat_reproduces (p : Fin n → ℝ) (hp0 : ∀ k, 0 ≤ p k)
    (hp1 : ∑ k, p k = 1) :
    ∃ v : Fin n → ℍ[ℝ], (∑ k, Quaternion.normSq (v k) = 1) ∧ ∀ k, qbornProb v k = p k := by sorry
