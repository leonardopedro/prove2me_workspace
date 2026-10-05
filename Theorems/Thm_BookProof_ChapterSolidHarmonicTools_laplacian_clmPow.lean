-- Generated from ChapterSolidHarmonicTools.lean — theorem BookProof.ChapterSolidHarmonicTools.laplacian_clmPow
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



theorem BookProof.ChapterSolidHarmonicTools.laplacian_clmPow (ψ : E →L[ℝ] ℂ) (k : ℕ) (x : E) :
    (Δ fun y => (ψ y) ^ k) x
      = (k : ℂ) * ((k : ℂ) - 1) * (ψ x) ^ (k - 2)
          * ∑ i, (ψ (stdOrthonormalBasis ℝ E i)) ^ 2 := by sorry
