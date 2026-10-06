-- Generated from ChapterRadialLaplacian.lean — solution of BookProof.ChapterRadialLaplacian.hasFDerivAt_normSq
import Mathlib
import Definitions.Def_ChapterRadialLaplacian
open BookProof.ChapterRadialLaplacian




open Filter Laplacian InnerProductSpace
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (x : E) :
    HasFDerivAt (fun z : E => ‖z‖ ^ 2) ((2 : ℝ) • innerCLM E x) x := by

  have h := (hasStrictFDerivAt_norm_sq x).hasFDerivAt
  convert h using 1
  ext y
  simp [two_smul]
