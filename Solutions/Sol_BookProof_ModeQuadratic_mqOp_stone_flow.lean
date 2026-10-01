-- Generated from ChapterModeQuadraticEsa.lean — solution of BookProof.ModeQuadratic.mqOp_stone_flow
import Mathlib
import Definitions.Def_ChapterModeQuadraticEsa
import Theorems.Thm_BookProof_ModeQuadratic_mqOp_symmetric
import Theorems.Thm_BookProof_ModeQuadratic_mqOp_essentiallySelfAdjoint
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
open BookProof.ModeQuadratic




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.CarlemanTwoStep
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p q s b b' : Fin d → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension (mqOp p q s b b') T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ polyGaussCore_dense (mqOp_symmetric p q s b b')
      (mqOp_essentiallySelfAdjoint p q s b b')
