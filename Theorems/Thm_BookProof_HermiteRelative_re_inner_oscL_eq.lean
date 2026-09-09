-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.re_inner_oscL_eq
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

set_option maxHeartbeats 1000000 in
-- the `L²` coercions of the Gauss–polynomial core make this defeq check expensive
theorem BookProof.HermiteRelative.re_inner_oscL_eq (i : Fin d) (u : polyGaussCore (d := d)) :
    (inner ℂ (u : L2d d) (oscL i u) : ℂ).re
      = ‖momL i u‖ ^ 2 + ‖posL i u‖ ^ 2 / 4 := by sorry
