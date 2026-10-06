-- Generated from ChapterNumericalRangeCrouzeix.lean — theorem BookProof.ChapterNumericalRangeCrouzeix.numRadiusLE_pow
import Mathlib
import Definitions.Def_ChapterNumericalRangeCrouzeix
open BookProof.ChapterNumericalRangeCrouzeix

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


open scoped InnerProductSpace



theorem BookProof.ChapterNumericalRangeCrouzeix.numRadiusLE_pow {A : E →L[ℂ] E} {r : ℝ} (hr : 0 ≤ r) (h : NumRadiusLE A r) (n : ℕ)
    (hn : 0 < n) : NumRadiusLE (A ^ n) (r ^ n) := by sorry
