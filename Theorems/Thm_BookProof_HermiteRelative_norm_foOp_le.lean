-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.norm_foOp_le
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

theorem BookProof.HermiteRelative.norm_foOp_le (c : Fin d → ℝ) {c0 : ℝ} (hc0 : 0 < c0) (hc : ∀ i, c0 ≤ c i)
    (b b' : Fin d → ℝ) {e : ℝ} (he : 0 < e) (u : polyGaussCore (d := d)) :
    ‖foOp b b' u‖
      ≤ (∑ i, (|b i| + |b' i|)) * (e * ‖quadOp c u‖ + (2 / (c0 * e)) * ‖(u : L2d d)‖) := by sorry
