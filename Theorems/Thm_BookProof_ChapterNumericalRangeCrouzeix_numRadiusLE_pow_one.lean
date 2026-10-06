-- Generated from ChapterNumericalRangeCrouzeix.lean — theorem BookProof.ChapterNumericalRangeCrouzeix.numRadiusLE_pow_one
import Mathlib
import Definitions.Def_ChapterNumericalRangeCrouzeix
open BookProof.ChapterNumericalRangeCrouzeix

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


open scoped InnerProductSpace



theorem BookProof.ChapterNumericalRangeCrouzeix.numRadiusLE_pow_one {A : E →L[ℂ] E} (h : NumRadiusLE A 1) (n : ℕ) (hn : 0 < n) :
    NumRadiusLE (A ^ n) 1 := by sorry
