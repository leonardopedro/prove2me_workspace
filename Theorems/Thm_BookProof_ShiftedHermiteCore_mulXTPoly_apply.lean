-- Generated from ChapterShiftedHermiteCore.lean — theorem BookProof.ShiftedHermiteCore.mulXTPoly_apply
import Mathlib
import Definitions.Def_ChapterShiftedHermiteCore
open BookProof.ShiftedHermiteCore










open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}

theorem BookProof.ShiftedHermiteCore.mulXTPoly_apply (a : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    mulXTPoly a i p = X i * p + ((a i : ℝ) : ℂ) • p := by sorry
