-- Generated from ChapterNumericalRangeCrouzeix.lean — theorem BookProof.ChapterNumericalRangeCrouzeix.crouzeix_disc
import Mathlib
import Definitions.Def_ChapterNumericalRangeCrouzeix
open BookProof.ChapterNumericalRangeCrouzeix


open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


theorem BookProof.ChapterNumericalRangeCrouzeix.crouzeix_disc [CompleteSpace E] {A : E →L[ℂ] E} {r M R : ℝ} (hr : 0 ≤ r)
    (hM : 0 ≤ M) (hR : r < R) (h : NumRadiusLE A r) {a : ℕ → ℂ}
    (ha : ∀ n, ‖a n‖ ≤ M / R ^ n) :
    ‖analyticFC a A‖ ≤ (1 + 2 * r / (R - r)) * M := by sorry
