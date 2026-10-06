-- Generated from ChapterNumericalRangeCrouzeix.lean — theorem BookProof.ChapterNumericalRangeCrouzeix.summable_analyticFC
import Mathlib
import Definitions.Def_ChapterNumericalRangeCrouzeix
open BookProof.ChapterNumericalRangeCrouzeix

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


open scoped InnerProductSpace



theorem BookProof.ChapterNumericalRangeCrouzeix.summable_analyticFC [CompleteSpace E] {A : E →L[ℂ] E} {r M R : ℝ} (hr : 0 ≤ r)
    (hM : 0 ≤ M) (hR : r < R) (h : NumRadiusLE A r) {a : ℕ → ℂ}
    (ha : ∀ n, ‖a n‖ ≤ M / R ^ n) : Summable fun n : ℕ => a n • A ^ n := by sorry
