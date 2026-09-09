-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.foOp_linear_apply_eq_mul
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

theorem BookProof.HermiteRelative.foOp_linear_apply_eq_mul (b : Fin d → ℝ) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFun (foPoly b 0 p) x = ((∑ i, b i * x i : ℝ) : ℂ) * pgFun p x := by sorry
