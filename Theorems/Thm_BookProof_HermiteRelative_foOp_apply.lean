-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.foOp_apply
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

 (d := d)) →ₗ[ℂ] L2d d :=
  (polyGaussCore (d := d)).subtype ∘ₗ coreOp (foPoly b b')

set_option maxHeartbeats 1000000 in
-- the `L²` coercions of the Gauss–polynomial core make this defeq check expensive
theorem BookProof.HermiteRelative.foOp_apply (b b' : Fin d → ℝ) (u : polyGaussCore (d := d)) : := by sorry
