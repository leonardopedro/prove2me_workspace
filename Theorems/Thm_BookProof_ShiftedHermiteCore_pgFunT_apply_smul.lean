-- Generated from ChapterShiftedHermiteCore.lean — theorem BookProof.ShiftedHermiteCore.pgFunT_apply_smul
import Mathlib
import Definitions.Def_ChapterShiftedHermiteCore
open BookProof.ShiftedHermiteCore










open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}

theorem BookProof.ShiftedHermiteCore.pgFunT_apply_smul (a k : Vd d) (c : ℂ) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFunT a k (c • p) x = c * pgFunT a k p x := by sorry
