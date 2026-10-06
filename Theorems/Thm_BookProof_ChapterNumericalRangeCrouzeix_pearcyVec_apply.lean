-- Generated from ChapterNumericalRangeCrouzeix.lean — theorem BookProof.ChapterNumericalRangeCrouzeix.pearcyVec_apply
import Mathlib
import Definitions.Def_ChapterNumericalRangeCrouzeix
open BookProof.ChapterNumericalRangeCrouzeix

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


open scoped InnerProductSpace



theorem BookProof.ChapterNumericalRangeCrouzeix.pearcyVec_apply (A : E →L[ℂ] E) (c : ℂ) (n : ℕ) (y : E) :
    pearcyVec A c n y - c • A (pearcyVec A c n y) = y - c ^ n • (A ^ n) y := by sorry
