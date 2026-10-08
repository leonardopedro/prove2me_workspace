-- Generated from ChapterShiftedQuadraticMatrixEsa.lean — solution of BookProof.ShiftedQuadraticMatrix.wave_rotated_linear_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticMatrixEsa
import Theorems.Thm_BookProof_ShiftedQuadraticMatrix_shiftedHMatOp_essentiallySelfAdjoint
import Theorems.Thm_BookProof_ShiftedQuadraticMatrix_rotConj_det
import Theorems.Thm_BookProof_ShiftedQuadraticMatrix_rotConj_isHermitian
import Theorems.Thm_BookProof_ShiftedQuadratic_minkowskiCoeff_ne_zero
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
theorem solution (n : ℕ)
    {O : Matrix (Fin (1 + n)) (Fin (1 + n)) ℝ} (hO : Oᵀ * O = 1)
    (b b' : Fin (1 + n) → ℝ) :
    EssentiallySelfAdjointOn
      (polyGaussCoreT (matShiftVec (rotConj O (minkowskiCoeff n)) b)
        (matBoostVec (rotConj O (minkowskiCoeff n)) b'))
      (shiftedHMatOp (matShiftVec (rotConj O (minkowskiCoeff n)) b)
        (matBoostVec (rotConj O (minkowskiCoeff n)) b')
        (rotConj O (minkowskiCoeff n)) b b') :=
  shiftedHMatOp_essentiallySelfAdjoint (rotConj_isHermitian O (minkowskiCoeff n))
      (by
        rw [isUnit_iff_ne_zero, rotConj_det hO]
        exact Finset.prod_ne_zero_iff.mpr fun i _ => minkowskiCoeff_ne_zero n i) b b'
