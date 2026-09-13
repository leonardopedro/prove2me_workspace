-- Generated from ChapterShiftedHermiteCore.lean — solution of BookProof.ShiftedHermiteCore.pgFunT_momTPoly
import Mathlib
import Definitions.Def_ChapterShiftedHermiteCore
import Theorems.Thm_BookProof_ShiftedHermiteCore_pgFunT_apply_add
import Theorems.Thm_BookProof_ShiftedHermiteCore_pgFunT_apply_smul
import Theorems.Thm_BookProof_ShiftedHermiteCore_deriv_pgFunT_sec
import Theorems.Thm_BookProof_ShiftedHermiteCore_momTPoly_apply
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
    pgFunT a k (momTPoly k i p) x
      = -Complex.I * deriv (fun t : ℝ => pgFunT a k p (sec i x t)) (x i) := by

  rw [deriv_pgFunT_sec, momTPoly_apply, pgFunT_apply_add, pgFunT_apply_smul,
    momPoly_apply' i p, pgFunT_apply_smul]
  rw [← dPoly_apply]
  linear_combination (((k i : ℝ) : ℂ) * pgFunT a k p x) * Complex.I_mul_I
