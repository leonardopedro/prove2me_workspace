-- Generated from ChapterSolidHarmonicTools.lean — theorem BookProof.ChapterSolidHarmonicTools.laplacian_normSqPow
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



theorem BookProof.ChapterSolidHarmonicTools.laplacian_normSqPow (m : ℕ) (x : E) :
    (Δ fun y : E => (‖y‖ ^ 2) ^ m) x
      = (4 * m * ((m : ℝ) - 1) + 2 * (Module.finrank ℝ E) * m) * (‖x‖ ^ 2) ^ (m - 1) := by sorry
