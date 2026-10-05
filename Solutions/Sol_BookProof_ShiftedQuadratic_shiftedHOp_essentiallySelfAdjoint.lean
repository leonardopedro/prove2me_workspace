-- Generated from ChapterShiftedQuadraticEsa.lean — solution of BookProof.ShiftedQuadratic.shiftedHOp_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticEsa
import Theorems.Thm_BookProof_ShiftedQuadratic_shiftedHOp_deficiencyTrivialAt
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
    EssentiallySelfAdjointOn (polyGaussCoreT (shiftVec c b) (boostVec c b'))
      (shiftedHOp (shiftVec c b) (boostVec c b') c b b') :=
  ⟨shiftedHOp_deficiencyTrivialAt c b b' hc (by simp),
     shiftedHOp_deficiencyTrivialAt c b b' hc (by simp)⟩
