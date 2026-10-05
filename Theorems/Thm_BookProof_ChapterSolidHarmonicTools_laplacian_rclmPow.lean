-- Generated from ChapterSolidHarmonicTools.lean — theorem BookProof.ChapterSolidHarmonicTools.laplacian_rclmPow
import Definitions.Def_ChapterRadialLaplacian
import Definitions.Def_ChapterLaplacianProduct
import Mathlib
import Definitions.Def_ChapterSolidHarmonicTools
open BookProof.ChapterSolidHarmonicTools

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]



open Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open BookProof.ChapterLaplacianProduct
open scoped RealInnerProductSpace



theorem BookProof.ChapterSolidHarmonicTools.laplacian_rclmPow (L : E →L[ℝ] ℝ) (k : ℕ) (x : E) :
    (Δ fun y => (L y) ^ k) x
      = (k : ℝ) * ((k : ℝ) - 1) * (L x) ^ (k - 2)
          * ∑ i, (L (stdOrthonormalBasis ℝ E i)) ^ 2 := by sorry
