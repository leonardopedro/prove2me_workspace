-- Generated from ChapterShiftedQuadraticMatrixEsa.lean — solution of BookProof.ShiftedQuadraticMatrix.rotConj_det
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticMatrixEsa
import Theorems.Thm_BookProof_QuadraticRotation_rotConj_eq
open BookProof.ShiftedQuadraticMatrix




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.QuadraticRotation
open BookProof.ShiftedHermiteCore
open BookProof.ShiftedQuadratic
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) (c : Fin d → ℝ) :
    (rotConj O c).det = ∏ i, c i := by

  have hd : O.det * O.det = 1 := by
    have h := congrArg Matrix.det hO
    rw [Matrix.det_mul, Matrix.det_transpose, Matrix.det_one] at h
    exact h
  rw [rotConj_eq, Matrix.det_mul, Matrix.det_mul, Matrix.det_diagonal, Matrix.det_transpose]
  linear_combination (∏ i, c i) * hd
