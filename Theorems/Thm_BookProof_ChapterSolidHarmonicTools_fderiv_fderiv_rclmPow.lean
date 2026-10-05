-- Generated from ChapterSolidHarmonicTools.lean — theorem BookProof.ChapterSolidHarmonicTools.fderiv_fderiv_rclmPow
import Definitions.Def_ChapterRadialLaplacian
import Definitions.Def_ChapterLaplacianProduct
import Mathlib
import Definitions.Def_ChapterSolidHarmonicTools
open BookProof.ChapterSolidHarmonicTools

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]



open Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open BookProof.ChapterLaplacianProduct
open scoped RealInnerProductSpace



theorem BookProof.ChapterSolidHarmonicTools.fderiv_fderiv_rclmPow (L : E →L[ℝ] ℝ) (k : ℕ) (x v w : E) :
    fderiv ℝ (fderiv ℝ fun y => (L y) ^ k) x v w
      = (k : ℝ) * ((k : ℝ) - 1) * (L x) ^ (k - 2) * L v * L w := by sorry
