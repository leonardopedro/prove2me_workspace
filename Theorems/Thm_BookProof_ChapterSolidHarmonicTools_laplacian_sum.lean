-- Generated from ChapterSolidHarmonicTools.lean — theorem BookProof.ChapterSolidHarmonicTools.laplacian_sum
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



theorem BookProof.ChapterSolidHarmonicTools.laplacian_sum {ι : Type*} (s : Finset ι) (f : ι → E → ℝ) (x : E)
    (hf : ∀ i ∈ s, ContDiffAt ℝ 2 (f i) x) :
    (Δ fun y => ∑ i ∈ s, f i y) x = ∑ i ∈ s, (Δ (f i)) x := by sorry
