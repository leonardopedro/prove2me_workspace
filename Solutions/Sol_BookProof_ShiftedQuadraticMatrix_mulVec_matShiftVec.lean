-- Generated from ChapterShiftedQuadraticMatrixEsa.lean — solution of BookProof.ShiftedQuadraticMatrix.mulVec_matShiftVec
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticMatrixEsa
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
theorem solution {A : Matrix (Fin d) (Fin d) ℝ} (hdet : IsUnit A.det)
    (b : Fin d → ℝ) (i : Fin d) :
    ∑ j, A i j * (matShiftVec A b) j = -2 * b i := by

  have h : A *ᵥ (A⁻¹ *ᵥ fun j => -2 * b j) = fun j => -2 * b j := by
    rw [Matrix.mulVec_mulVec, Matrix.mul_nonsing_inv A hdet, Matrix.one_mulVec]
  calc ∑ j, A i j * (matShiftVec A b) j
      = (A *ᵥ (A⁻¹ *ᵥ fun j => -2 * b j)) i := rfl
    _ = -2 * b i := by rw [h]
