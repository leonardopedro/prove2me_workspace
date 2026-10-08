-- Generated from ChapterNumericalRangeCrouzeix.lean — theorem BookProof.ChapterNumericalRangeCrouzeix.norm_term_le
import Mathlib
import Definitions.Def_ChapterNumericalRangeCrouzeix
open BookProof.ChapterNumericalRangeCrouzeix


open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


theorem BookProof.ChapterNumericalRangeCrouzeix.norm_term_le [CompleteSpace E] {A : E →L[ℂ] E} {r M R : ℝ} (hr : 0 ≤ r)
    (hM : 0 ≤ M) (hR : r < R) (h : NumRadiusLE A r) {a : ℕ → ℂ}
    (ha : ∀ n, ‖a n‖ ≤ M / R ^ n) (n : ℕ) (hn : 0 < n) :
    ‖a n • A ^ n‖ ≤ 2 * M * (r / R) ^ n := by sorry
