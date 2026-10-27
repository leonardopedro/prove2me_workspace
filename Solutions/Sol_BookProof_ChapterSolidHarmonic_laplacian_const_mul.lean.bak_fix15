-- Generated from ChapterSolidHarmonic.lean — solution of BookProof.ChapterSolidHarmonic.laplacian_const_mul
import Mathlib
import Definitions.Def_ChapterSolidHarmonic
open BookProof.ChapterSolidHarmonic




open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterRadialLaplacian BookProof.ChapterLaplacianProduct
open BookProof.ChapterSolidHarmonicTools BookProof.ChapterLegendrePolynomial
open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {f : E → ℝ} {x : E} (c : ℝ) (hf : ContDiffAt ℝ 2 f x) :
    (Δ fun y => c * f y) x = c * (Δ f) x := by

  have hrw : (fun y => c * f y) = c • f := by funext y; simp
  rw [hrw, laplacian_smul c hf]
  simp
