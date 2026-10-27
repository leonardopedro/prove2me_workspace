-- Generated from ChapterShiftedQuadraticMatrixEsa.lean — solution of BookProof.ShiftedQuadraticMatrix.shiftedHMatOp_symmetric
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticMatrixEsa
import Theorems.Thm_BookProof_ShiftedQuadraticMatrix_shiftedHMatOp_rotConj_symmetric
import Theorems.Thm_BookProof_ShiftedQuadraticMatrix_mulVec_matShiftVec
import Theorems.Thm_BookProof_ShiftedQuadraticMatrix_mulVec_matBoostVec
import Theorems.Thm_BookProof_ShiftedQuadraticMatrix_entries_symm
import Theorems.Thm_BookProof_QuadraticRotation_exists_rotConj_eigenvalues
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
theorem solution {A : Matrix (Fin d) (Fin d) ℝ}
    (hA : A.IsHermitian) (hdet : IsUnit A.det) (b b' : Fin d → ℝ) :
    SymmetricOn (polyGaussCoreT (matShiftVec A b) (matBoostVec A b'))
      (shiftedHMatOp (matShiftVec A b) (matBoostVec A b') A b b') := by

  obtain ⟨O, hO, hAO⟩ := exists_rotConj_eigenvalues hA
  have hsym := entries_symm hA
  rw [hAO] at hsym hdet ⊢
  exact shiftedHMatOp_rotConj_symmetric hO _ _ _ b b' hsym
    (mulVec_matShiftVec hdet b) (mulVec_matBoostVec hdet b')
