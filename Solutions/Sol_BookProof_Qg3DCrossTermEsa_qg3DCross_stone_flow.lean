-- Generated from ChapterQg3DCrossTermEsa.lean — solution of BookProof.Qg3DCrossTermEsa.qg3DCross_stone_flow
import Mathlib
import Definitions.Def_ChapterQg3DCrossTermEsa
import Theorems.Thm_BookProof_Qg3DCrossTermEsa_qg3DCross_eq_fqOp
import Theorems.Thm_BookProof_FullQuadratic_fqOp_stone_flow
open BookProof.Qg3DCrossTermEsa




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.QuantumGravity3DGauge
open BookProof.Qg3DGaugeEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.TensorCore BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa BookProof.FockSecondQuantization BookProof.QuadFockEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (Q' : Fin 84 → Fin 84 → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2d 84)) (U : ℝ → (L2d 84 →L[ℂ] L2d 84)),
      IsSelfAdjointExtension (qg3DCrossHamiltonian Q') T.op ∧ IsStoneFlow T U := by

  rw [qg3DCross_eq_fqOp]
  exact fqOp_stone_flow _ _ _ _ _
