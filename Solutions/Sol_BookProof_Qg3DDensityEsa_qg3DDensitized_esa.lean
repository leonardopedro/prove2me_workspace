-- Generated from ChapterQg3DDensityEsa.lean — solution of BookProof.Qg3DDensityEsa.qg3DDensitized_esa
import Mathlib
import Definitions.Def_ChapterQg3DDensityEsa
import Theorems.Thm_BookProof_FullQuadratic_fqOp_essentiallySelfAdjoint
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
theorem solution (y : ℝ) (St : Fin 4 → Fin 4 → Fin 84 → ℝ) (Pt : Fin 84 → ℝ)
    (Qb : Fin 84 → Fin 84 → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 84)) (qg3DDensitizedHam y St Pt Qb) := fqOp_essentiallySelfAdjoint _ _ _ _ _
