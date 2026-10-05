-- Generated from ChapterShiftedQuadraticMatrixEsa.lean — solution of BookProof.ShiftedQuadraticMatrix.shiftedHMatOp_stone_flow
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticMatrixEsa
import Theorems.Thm_BookProof_ShiftedQuadraticMatrix_shiftedHMatOp_essentiallySelfAdjoint
import Theorems.Thm_BookProof_ShiftedQuadraticMatrix_shiftedHMatOp_symmetric
import Theorems.Thm_BookProof_ShiftedQuadraticMatrix_shiftedHMatCore_dense
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
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
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension
        (shiftedHMatOp (matShiftVec A b) (matBoostVec A b') A b b') T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ (shiftedHMatCore_dense b b')
      (shiftedHMatOp_symmetric hA hdet b b')
      (shiftedHMatOp_essentiallySelfAdjoint hA hdet b b')
