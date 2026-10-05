-- Generated from ChapterShiftedQuadraticMatrixEsa.lean — solution of BookProof.ShiftedQuadraticMatrix.shiftedHMatOp_rotConj_deficiencyTrivialAt
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticMatrixEsa
import Theorems.Thm_BookProof_ShiftedQuadraticMatrix_hermiteTRLp_mem_coreT
import Theorems.Thm_BookProof_ShiftedQuadraticMatrix_hermiteTRLp_total
import Theorems.Thm_BookProof_ShiftedQuadraticMatrix_shiftedHMatOp_hermiteTRLp
import Theorems.Thm_BookProof_HyperbolicQuadratic_deficiencyTrivialAt_of_diagonal
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
theorem solution {O : Matrix (Fin d) (Fin d) ℝ}
    (hO : Oᵀ * O = 1) (c : Fin d → ℝ) (a k : Vd d) (b b' : Fin d → ℝ)
    (hsym : ∀ i j, rotConj O c i j = rotConj O c j i)
    (ha : ∀ i, ∑ j, rotConj O c i j * a j = -2 * b i)
    (hk : ∀ i, ∑ j, rotConj O c i j * k j = -(b' i) / 2)
    {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (polyGaussCoreT a k) (shiftedHMatOp a k (rotConj O c) b b') z :=
  deficiencyTrivialAt_of_diagonal (hermiteTRLp O a k)
      (fun α => quadSymbol c α + matShiftConst a k b b') (hermiteTRLp_total hO a k) _
      (hermiteTRLp_mem_coreT O a k)
      (fun α h => shiftedHMatOp_hermiteTRLp hO c a k b b' hsym ha hk α h) hz
