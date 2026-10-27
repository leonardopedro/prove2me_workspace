-- Generated from ChapterSolidHarmonicTools.lean — solution of BookProof.ChapterSolidHarmonicTools.hasFDerivAt_clmPow
import Mathlib
import Definitions.Def_ChapterSolidHarmonicTools
open BookProof.ChapterSolidHarmonicTools




open Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open BookProof.ChapterLaplacianProduct
open scoped RealInnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (ψ : E →L[ℝ] ℂ) (k : ℕ) (x : E) :
    HasFDerivAt (fun y => (ψ y) ^ k) (((k : ℂ) * (ψ x) ^ (k - 1)) • (ψ : E →L[ℝ] ℂ)) x := (hasDerivAt_pow k (ψ x)).comp_hasFDerivAt x ψ.hasFDerivAt
