-- Generated from ChapterShiftedQuadraticEsa.lean — solution of BookProof.ShiftedQuadratic.shiftedHOp_symmetric
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticEsa
import Theorems.Thm_BookProof_ShiftedQuadratic_shiftedHOp_hermiteTLp
import Theorems.Thm_BookProof_HyperbolicQuadratic_symmetricOn_of_diagonal
import Theorems.Thm_BookProof_ShiftedHermiteCore_orthonormal_hermiteTLp
import Theorems.Thm_BookProof_ShiftedHermiteCore_span_hermiteTLp
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
theorem solution (c b b' : Fin d → ℝ) (hc : ∀ i, c i ≠ 0) :
    SymmetricOn (polyGaussCoreT (shiftVec c b) (boostVec c b'))
      (shiftedHOp (shiftVec c b) (boostVec c b') c b b') :=
  symmetricOn_of_diagonal (hermiteTLp (shiftVec c b) (boostVec c b'))
      (orthonormal_hermiteTLp _ _) (fun α => quadSymbol c α + shiftConst c b b')
      (span_hermiteTLp _ _) _ (fun α h => shiftedHOp_hermiteTLp c b b' hc α h)
