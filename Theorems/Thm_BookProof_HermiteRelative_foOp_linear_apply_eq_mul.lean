-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.foOp_linear_apply_eq_mul
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

r_apply_apply, hermiteMvBasis_apply]
  exact hsym.symm

theorem BookProof.HermiteRelative.foOp_linear_apply_eq_mul (b : Fin d → ℝ) (p : MvPolynomial (Fin := by sorry
