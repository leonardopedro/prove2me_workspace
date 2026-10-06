-- Generated from ChapterRadialLaplacian.lean — theorem BookProof.ChapterRadialLaplacian.hasFDerivAt_normSq
import Mathlib
import Definitions.Def_ChapterRadialLaplacian
open BookProof.ChapterRadialLaplacian

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]



open Filter Laplacian InnerProductSpace
open scoped InnerProductSpace RealInnerProductSpace


theorem BookProof.ChapterRadialLaplacian.hasFDerivAt_normSq (x : E) :
    HasFDerivAt (fun z : E => ‖z‖ ^ 2) ((2 : ℝ) • innerCLM E x) x := by sorry
