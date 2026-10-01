-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.norm_posL_le
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
open BookProof.HermiteRelative

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}
variable {d : ℕ}



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

inarith [sq_nonneg (e * A), sq_nonneg ((2 / (c0 * e)) * B), h, hcross]
  nlinarith [hsq, hrhs]

theorem BookProof.HermiteRelative.norm_posL_le (c : Fin d → ℝ) {c0 : ℝ} (hc0 : 0 < c0) (hc : ∀ i, c0 ≤ c i)
    {e : ℝ} (he : 0 < e) (i : Fin d) (u : polyGaussCo := by sorry
