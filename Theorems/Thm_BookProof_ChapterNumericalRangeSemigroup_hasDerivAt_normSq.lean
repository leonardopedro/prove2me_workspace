-- Generated from ChapterNumericalRangeSemigroup.lean — theorem BookProof.ChapterNumericalRangeSemigroup.hasDerivAt_normSq
import Mathlib
import Definitions.Def_ChapterNumericalRangeSemigroup
open BookProof.ChapterNumericalRangeSemigroup


open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


theorem BookProof.ChapterNumericalRangeSemigroup.hasDerivAt_normSq (A : E →L[ℂ] E) (x : E) (t : ℝ) :
    HasDerivAt (fun s : ℝ => ‖(NormedSpace.exp (s • A)) x‖ ^ 2)
      (2 * (inner ℂ (NormedSpace.exp (t • A) x) (A (NormedSpace.exp (t • A) x))).re) t := by sorry
