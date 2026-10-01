-- Generated from ChapterHermiteRelativeBound.lean — solution of BookProof.HermiteRelative.norm_posL_le
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
import Theorems.Thm_BookProof_HermiteRelative_norm_posL_sq_le
import Theorems.Thm_BookProof_HermiteRelative_le_relBound_of_sq_le
open BookProof.HermiteRelative




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

set_option maxHeartbeats 1000000 in
inarith [sq_nonneg (e * A), sq_nonneg ((2 / (c0 * e)) * B), h, hcross]
  nlinarith [hsq, hrhs]

theorem solution (c : Fin d → ℝ) {c0 : ℝ} (hc0 : 0 < c0) (hc : ∀ i, c0 ≤ c i)
    {e : ℝ} (he : 0 < e) (i : Fin d) (u : polyGaussCo :=
  re (d := d)) :
      ‖posL i u‖ ≤ e * ‖quadOp c u‖ + (2 / (c0 * e)) * ‖(u : L2d d)‖ :=
