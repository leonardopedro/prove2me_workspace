-- Generated from ChapterQuadraticRotationEsa.lean — solution of BookProof.QuadraticRotation.rotConj_eq
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
open BookProof.QuadraticRotation




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (O : Matrix (Fin d) (Fin d) ℝ) (c : Fin d → ℝ) :
    rotConj O c = O * Matrix.diagonal c * Oᵀ := by

  ext k l
  simp only [rotConj, Matrix.mul_apply, Matrix.transpose_apply, Matrix.diagonal_apply]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finset.sum_eq_single j (fun i _ hi => by simp [hi]) (by simp)]
  simp
