-- Generated from ChapterShiftedHermiteCore.lean — solution of BookProof.ShiftedHermiteCore.pgFunT_mulXTPoly
import Mathlib
import Definitions.Def_ChapterShiftedHermiteCore
import Theorems.Thm_BookProof_ShiftedHermiteCore_pgFunT_apply_add
import Theorems.Thm_BookProof_ShiftedHermiteCore_pgFunT_apply_smul
import Theorems.Thm_BookProof_ShiftedHermiteCore_mulXTPoly_apply
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
open BookProof.ShiftedHermiteCore











open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a k : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFunT a k (mulXTPoly a i p) x = ((x i : ℝ) : ℂ) * pgFunT a k p x := by

  rw [mulXTPoly_apply, pgFunT_apply_add, pgFunT_apply_smul]
  have hx : pgFunT a k (X i * p) x = (((x - a) i : ℝ) : ℂ) * pgFunT a k p x := by
    rw [pgFunT, pgFunT]
    have := posOp_apply_eq_mul i p (x - a)
    rw [mulXPoly_apply] at this
    rw [this]
    ring
  rw [hx]
  have hxa : ((x - a) i : ℝ) = x i - a i := by simp
  rw [hxa]
  push_cast
  ring
