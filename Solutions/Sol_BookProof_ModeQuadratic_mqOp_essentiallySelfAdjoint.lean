-- Generated from ChapterModeQuadraticEsa.lean — solution of BookProof.ModeQuadratic.mqOp_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterModeQuadraticEsa
import Theorems.Thm_BookProof_ModeQuadratic_mqOp_deficiencyTrivialAt
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

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p q s b b' : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (mqOp p q s b b') :=
  ⟨mqOp_deficiencyTrivialAt p q s b b' (by simp),
      mqOp_deficiencyTrivialAt p q s b b' (by simp)⟩
