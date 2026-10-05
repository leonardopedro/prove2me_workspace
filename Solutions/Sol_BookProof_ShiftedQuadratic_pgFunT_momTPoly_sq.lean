-- Generated from ChapterShiftedQuadraticEsa.lean — solution of BookProof.ShiftedQuadratic.pgFunT_momTPoly_sq
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticEsa
import Theorems.Thm_BookProof_ShiftedQuadratic_momTPoly_eq_smul
import Theorems.Thm_BookProof_ShiftedQuadratic_deriv2_pgFunT_sec
import Theorems.Thm_BookProof_ShiftedHermiteCore_pgFunT_apply_smul
open BookProof.ShiftedQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.ShiftedHermiteCore
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a k : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFunT a k (momTPoly k i (momTPoly k i p)) x
      = -deriv (fun t : ℝ => deriv (fun s : ℝ => pgFunT a k p (sec i x s)) t) (x i) := by

  have h1 : momTPoly k i (momTPoly k i p) = (-1 : ℂ) • dPolyT k i (dPolyT k i p) := by
    conv_lhs => rw [momTPoly_eq_smul k i (momTPoly k i p)]
    rw [momTPoly_eq_smul k i p, map_smul, smul_smul]
    congr 1
    linear_combination Complex.I_mul_I
  rw [h1, pgFunT_apply_smul, deriv2_pgFunT_sec]
  ring
