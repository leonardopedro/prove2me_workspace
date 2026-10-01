-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.hermiteMvBasis_repr_quadOp
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

 u‖ + K * (2 / (c0 * e)) * ‖(u : L2d d)‖ := by ring

theorem BookProof.HermiteRelative.hermiteMvBasis_repr_quadOp (c : Fin d → ℝ) (u : polyGaussCore (d := d))
    (a : Fin d →₀ ℕ) :
    hermiteMvBasis := by sorry
