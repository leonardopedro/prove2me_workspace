-- Generated from ChapterSolidHarmonic.lean — solution of BookProof.ChapterSolidHarmonic.angularIm_axis
import Mathlib
import Definitions.Def_ChapterSolidHarmonic
import Theorems.Thm_BookProof_ChapterSolidHarmonic_fderiv_angularIm
open BookProof.ChapterSolidHarmonic




open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterRadialLaplacian BookProof.ChapterLaplacianProduct
open BookProof.ChapterSolidHarmonicTools BookProof.ChapterLegendrePolynomial
open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {u v e : E} (hue : ⟪u, e⟫_ℝ = 0) (hve : ⟪v, e⟫_ℝ = 0) (μ : ℕ) (x : E) :
    fderiv ℝ (angularIm u v μ) x e = 0 := by

  have h0 : nullCLM u v e = 0 := by
    rw [nullCLM_apply, hue, hve]
    simp
  rw [fderiv_angularIm, h0, mul_zero]
  simp
