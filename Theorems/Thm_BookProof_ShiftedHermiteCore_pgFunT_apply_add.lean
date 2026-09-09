-- Generated from ChapterShiftedHermiteCore.lean — theorem BookProof.ShiftedHermiteCore.pgFunT_apply_add
import Mathlib
import Definitions.Def_ChapterShiftedHermiteCore
open BookProof.ShiftedHermiteCore










open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}

theorem BookProof.ShiftedHermiteCore.pgFunT_apply_add (a k : Vd d) (p q : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFunT a k (p + q) x = pgFunT a k p x + pgFunT a k q x := by sorry
