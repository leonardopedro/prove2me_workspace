-- Generated from ChapterShiftedQuadraticDegenerate.lean — solution of BookProof.ShiftedQuadraticDegenerate.diagonal_mulVec_diagShiftVec
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticDegenerate
open BookProof.ShiftedQuadraticDegenerate




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HyperbolicQuadratic
open BookProof.QuadraticRotation
open BookProof.ShiftedHermiteCore
open BookProof.ShiftedQuadratic
open BookProof.ShiftedQuadraticMatrix
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.StoneEigenflow

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {c w : Fin d → ℝ} (hcw : ∀ i, c i = 0 → w i = 0)
    (i : Fin d) : ∑ j, (Matrix.diagonal c) i j * (diagShiftVec c w) j = w i := by

  classical
  rw [Finset.sum_eq_single i (fun j _ hj => by simp [Ne.symm hj])
    (by simp)]
  by_cases h : c i = 0
  · simp [Matrix.diagonal_apply_eq, diagShiftVec, h, hcw i h]
  · simp only [Matrix.diagonal_apply_eq, diagShiftVec, WithLp.ofLp_toLp, h, if_false]
    field_simp
