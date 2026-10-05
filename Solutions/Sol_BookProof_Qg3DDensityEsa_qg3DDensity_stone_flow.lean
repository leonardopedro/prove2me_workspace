-- Generated from ChapterQg3DDensityEsa.lean — solution of BookProof.Qg3DDensityEsa.qg3DDensity_stone_flow
import Mathlib
import Definitions.Def_ChapterQg3DDensityEsa
import Theorems.Thm_BookProof_FullQuadratic_fqOp_stone_flow
open BookProof.Qg3DDensityEsa




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.QuantumGravity3DGauge
open BookProof.Qg3DGaugeEsa
open BookProof.Qg3DCrossTermEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.TensorCore BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa BookProof.FockSecondQuantization BookProof.QuadFockEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (e : ℝ) (chi : Fin 4 → Fin 4 → ℝ) (Qb : Fin 84 → Fin 84 → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2d 84)) (U : ℝ → (L2d 84 →L[ℂ] L2d 84)),
      IsSelfAdjointExtension (qg3DDensityHam e chi Qb) T.op ∧ IsStoneFlow T U := fqOp_stone_flow _ _ _ _ _
