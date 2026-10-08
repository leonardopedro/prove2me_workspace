-- Generated from ChapterSolidHarmonicTools.lean — theorem BookProof.ChapterSolidHarmonicTools.hasFDerivAt_clmPow
import Definitions.Def_ChapterRadialLaplacian
import Definitions.Def_ChapterLaplacianProduct
import Mathlib
import Definitions.Def_ChapterSolidHarmonicTools
open BookProof.ChapterSolidHarmonicTools



open Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open BookProof.ChapterLaplacianProduct
open scoped RealInnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterSolidHarmonicTools.hasFDerivAt_clmPow (ψ : E →L[ℝ] ℂ) (k : ℕ) (x : E) :
    HasFDerivAt (fun y => (ψ y) ^ k) (((k : ℂ) * (ψ x) ^ (k - 1)) • (ψ : E →L[ℝ] ℂ)) x := by sorry
