-- Generated from ChapterSolidHarmonic.lean — solution of BookProof.ChapterSolidHarmonic.solidHarmonicIm_harmonic
import Mathlib
import Definitions.Def_ChapterSolidHarmonic
import Theorems.Thm_BookProof_ChapterSolidHarmonic_contDiff_angularIm
import Theorems.Thm_BookProof_ChapterSolidHarmonic_angularIm_harmonic
import Theorems.Thm_BookProof_ChapterSolidHarmonic_angularIm_euler
import Theorems.Thm_BookProof_ChapterSolidHarmonic_angularIm_axis
import Theorems.Thm_BookProof_ChapterSolidHarmonic_laplacian_angular_mul_sum
import Theorems.Thm_BookProof_ChapterSolidHarmonic_legendre_rec_factored
open BookProof.ChapterSolidHarmonic




open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterRadialLaplacian BookProof.ChapterLaplacianProduct
open BookProof.ChapterSolidHarmonicTools BookProof.ChapterLegendrePolynomial
open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {u v e : E} (hu : ‖u‖ = 1) (hv : ‖v‖ = 1) (he : ‖e‖ = 1)
    (huv : ⟪u, v⟫_ℝ = 0) (hue : ⟪u, e⟫_ℝ = 0) (hve : ⟪v, e⟫_ℝ = 0)
    (h3 : Module.finrank ℝ E = 3) {l μ : ℕ} (hμ : μ ≤ l) (x : E) :
    (Δ (solidHarmonicIm u v e l μ)) x = 0 := by

  have hfun : solidHarmonicIm u v e l μ
      = fun y : E => ∑ m ∈ Finset.range ((l - μ) / 2 + 1),
          (derivative^[μ] (legendre l)).coeff (l - μ - 2 * m)
            * (angularIm u v μ y * ((⟪e, y⟫_ℝ) ^ (l - μ - 2 * m) * (‖y‖ ^ 2) ^ m)) := by
    funext y
    rw [solidHarmonicIm, radialFactor, Finset.mul_sum]
    exact Finset.sum_congr rfl fun m _ => by ring
  rw [hfun]
  exact laplacian_angular_mul_sum he (l - μ) h3 (contDiff_angularIm u v μ).contDiffAt
    (angularIm_harmonic hu hv huv μ x) (angularIm_euler u v μ x) (angularIm_axis hue hve μ x) _
    (legendre_rec_factored hμ)
