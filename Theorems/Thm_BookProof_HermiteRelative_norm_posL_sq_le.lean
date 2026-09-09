-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.norm_posL_sq_le
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
open BookProof.HermiteRelative









open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}





variable {d : ℕ}

theorem BookProof.HermiteRelative.norm_posL_sq_le (c : Fin d → ℝ) {c0 : ℝ} (hc0 : 0 < c0) (hc : ∀ i, c0 ≤ c i)
    (i : Fin d) (u : polyGaussCore (d := d)) :
    ‖posL i u‖ ^ 2 ≤ (4 / c0) * (‖(u : L2d d)‖ * ‖quadOp c u‖) := by sorry
