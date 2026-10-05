-- Generated from ChapterSolidHarmonicTools.lean — theorem BookProof.ChapterSolidHarmonicTools.laplacian_angular_mul
import Definitions.Def_ChapterLaplacianProduct
import Mathlib
import Definitions.Def_ChapterSolidHarmonicTools
import Definitions.Def_ChapterRadialLaplacian
open BookProof.ChapterRadialLaplacian
open BookProof.ChapterSolidHarmonicTools

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]



open Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open BookProof.ChapterLaplacianProduct
open scoped RealInnerProductSpace



theorem BookProof.ChapterSolidHarmonicTools.laplacian_angular_mul {A B : E → ℝ} {x : E} {α β : ℝ} {e : E} {μ : ℕ}
    (hA : ContDiffAt ℝ 2 A x) (hB : ContDiffAt ℝ 2 B x)
    (hharm : (Δ A) x = 0) (heuler : fderiv ℝ A x x = μ * A x) (haxis : fderiv ℝ A x e = 0)
    (hgrad : fderiv ℝ B x = α • innerCLM E e + β • innerCLM E x) :
    (Δ fun y : E => A y * B y) x = A x * (Δ B) x + 2 * β * (μ : ℝ) * A x := by sorry
