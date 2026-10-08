-- Generated from ChapterSolidHarmonicTools.lean — theorem BookProof.ChapterSolidHarmonicTools.hasFDerivAt_rclmPow
import Definitions.Def_ChapterRadialLaplacian
import Definitions.Def_ChapterLaplacianProduct
import Mathlib
import Definitions.Def_ChapterSolidHarmonicTools
open BookProof.ChapterSolidHarmonicTools



open Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open BookProof.ChapterLaplacianProduct
open scoped RealInnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterSolidHarmonicTools.hasFDerivAt_rclmPow (L : E →L[ℝ] ℝ) (k : ℕ) (x : E) :
    HasFDerivAt (fun y => (L y) ^ k) (((k : ℝ) * (L x) ^ (k - 1)) • (L : E →L[ℝ] ℝ)) x := by sorry
