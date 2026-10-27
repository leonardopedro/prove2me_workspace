-- Generated from ChapterQg3DCrossTermEsa.lean — solution of BookProof.Qg3DCrossTermEsa.qgWithCoupling_esa
import Mathlib
import Definitions.Def_ChapterQg3DCrossTermEsa
import Theorems.Thm_BookProof_Qg3DCrossTermEsa_qgWithCoupling_eq_fqOp
import Theorems.Thm_BookProof_FullQuadratic_fqOp_essentiallySelfAdjoint
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
theorem solution (kappa : Fin 84 → ℝ) (Q' C : Fin 84 → Fin 84 → ℝ)
    (b b' : Fin 84 → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 84)) (qgWithCoupling kappa Q' C b b') := by

  rw [qgWithCoupling_eq_fqOp]
  exact fqOp_essentiallySelfAdjoint _ _ _ _ _
