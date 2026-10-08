-- Generated from ChapterNumericalRangeSemigroup.lean — theorem BookProof.ChapterNumericalRangeSemigroup.hasDerivAt_expApply
import Mathlib
import Definitions.Def_ChapterNumericalRangeSemigroup
open BookProof.ChapterNumericalRangeSemigroup


open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


theorem BookProof.ChapterNumericalRangeSemigroup.hasDerivAt_expApply (A : E →L[ℂ] E) (x : E) (t : ℝ) :
    HasDerivAt (fun s : ℝ => (NormedSpace.exp (s • A)) x) (A (NormedSpace.exp (t • A) x)) t := by sorry
