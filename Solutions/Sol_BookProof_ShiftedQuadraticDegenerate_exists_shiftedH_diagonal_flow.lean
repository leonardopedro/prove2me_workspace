-- Generated from ChapterShiftedQuadraticDegenerate.lean — solution of BookProof.ShiftedQuadraticDegenerate.exists_shiftedH_diagonal_flow
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticDegenerate
import Theorems.Thm_BookProof_ShiftedHermiteCore_hermiteTLp_mem_coreT
import Theorems.Thm_BookProof_ShiftedQuadratic_shiftedCore_dense
import Theorems.Thm_BookProof_ShiftedQuadratic_shiftedHOp_essentiallySelfAdjoint
import Theorems.Thm_BookProof_ShiftedQuadratic_shiftedHOp_hermiteTLp
import Theorems.Thm_BookProof_ShiftedQuadratic_shiftedHOp_symmetric
import Theorems.Thm_BookProof_StoneEigenflow_exists_diagonal_stone_flow
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
theorem solution (c b b' : Fin d → ℝ) (hc : ∀ i, c i ≠ 0) :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension
        (shiftedHOp (shiftVec c b) (boostVec c b') c b b') T.op ∧
      IsStoneFlow T U ∧
      ∀ (α : Fin d →₀ ℕ) (t : ℝ),
        U t (hermiteTLp (shiftVec c b) (boostVec c b') α)
          = Complex.exp (-(Complex.I * ((quadSymbol c α + shiftConst c b b' : ℝ) : ℂ) * t))
              • hermiteTLp (shiftVec c b) (boostVec c b') α :=
  exists_diagonal_stone_flow _ (shiftedCore_dense c b b')
      (shiftedHOp_symmetric c b b' hc) (shiftedHOp_essentiallySelfAdjoint c b b' hc)
      (fun α => (⟨hermiteTLp (shiftVec c b) (boostVec c b') α,
        hermiteTLp_mem_coreT _ _ α⟩ : polyGaussCoreT (shiftVec c b) (boostVec c b')))
      (fun α => quadSymbol c α + shiftConst c b b')
      (fun α => shiftedHOp_hermiteTLp c b b' hc α (hermiteTLp_mem_coreT _ _ α))
