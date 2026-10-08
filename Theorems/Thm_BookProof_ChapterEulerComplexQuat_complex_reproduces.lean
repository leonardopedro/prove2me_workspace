-- Generated from ChapterEulerComplexQuat.lean — theorem BookProof.ChapterEulerComplexQuat.complex_reproduces
import Mathlib
import Definitions.Def_ChapterEulerComplexQuat
open BookProof.ChapterEulerComplexQuat


open scoped Quaternion BigOperators


variable {n : ℕ}


theorem BookProof.ChapterEulerComplexQuat.complex_reproduces (p : Fin n → ℝ) (hp0 : ∀ k, 0 ≤ p k)
    (hp1 : ∑ k, p k = 1) :
    ∃ v : Fin n → ℂ, (∑ k, Complex.normSq (v k) = 1) ∧ ∀ k, cbornProb v k = p k := by sorry
