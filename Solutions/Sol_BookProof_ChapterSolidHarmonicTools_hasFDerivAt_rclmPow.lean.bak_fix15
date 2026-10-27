-- Generated from ChapterSolidHarmonicTools.lean — solution of BookProof.ChapterSolidHarmonicTools.hasFDerivAt_rclmPow
import Mathlib
import Definitions.Def_ChapterSolidHarmonicTools
open BookProof.ChapterSolidHarmonicTools




open Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open BookProof.ChapterLaplacianProduct
open scoped RealInnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (L : E →L[ℝ] ℝ) (k : ℕ) (x : E) :
    HasFDerivAt (fun y => (L y) ^ k) (((k : ℝ) * (L x) ^ (k - 1)) • (L : E →L[ℝ] ℝ)) x := (hasDerivAt_pow k (L x)).comp_hasFDerivAt x L.hasFDerivAt
