-- Generated from ChapterSolidHarmonicTools.lean — theorem BookProof.ChapterSolidHarmonicTools.fderiv_fderiv_clmPow
import Definitions.Def_ChapterRadialLaplacian
import Definitions.Def_ChapterLaplacianProduct
import Mathlib
import Definitions.Def_ChapterSolidHarmonicTools
open BookProof.ChapterSolidHarmonicTools



open Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open BookProof.ChapterLaplacianProduct
open scoped RealInnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterSolidHarmonicTools.fderiv_fderiv_clmPow (ψ : E →L[ℝ] ℂ) (k : ℕ) (x v w : E) :
    fderiv ℝ (fderiv ℝ fun y => (ψ y) ^ k) x v w
      = (k : ℂ) * ((k : ℂ) - 1) * (ψ x) ^ (k - 2) * ψ v * ψ w := by sorry
