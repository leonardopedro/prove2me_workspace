-- Generated from ChapterSolidHarmonic.lean — solution of BookProof.ChapterSolidHarmonic.inner_e_spherePt
import Mathlib
import Definitions.Def_ChapterSolidHarmonic
open BookProof.ChapterSolidHarmonic




open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterRadialLaplacian BookProof.ChapterLaplacianProduct
open BookProof.ChapterSolidHarmonicTools BookProof.ChapterLegendrePolynomial
open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
variable {u v e : E} (hu : ‖u‖ = 1) (hv : ‖v‖ = 1) (he : ‖e‖ = 1)
  (huv : ⟪u, v⟫_ℝ = 0) (hue : ⟪u, e⟫_ℝ = 0) (hve : ⟪v, e⟫_ℝ = 0)

set_option maxHeartbeats 1000000 in
theorem solution (r θ φ : ℝ) :
    ⟪e, spherePt u v e r θ φ⟫_ℝ = r * Real.cos θ := by

  have heu : ⟪e, u⟫_ℝ = 0 := by rw [real_inner_comm]; exact hue
  have hev : ⟪e, v⟫_ℝ = 0 := by rw [real_inner_comm]; exact hve
  simp only [spherePt, inner_add_right, real_inner_smul_right, heu, hev,
    real_inner_self_eq_norm_sq, he]
  ring
