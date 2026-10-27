-- Generated from ChapterQg3DDensityEsa.lean — solution of BookProof.Qg3DDensityEsa.qgFibredDensity_symmetricOn
import Mathlib
import Definitions.Def_ChapterQg3DDensityEsa
import Theorems.Thm_BookProof_Qg3DDensityEsa_qg3DDensity_symmetricOn
import Theorems.Thm_BookProof_DirectSumEsa_dsOp_symmetricOn
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
theorem solution {ι : Type*} (bg : ι → Matrix (Fin 4) (Fin 4) ℝ)
    (Qb : ι → Fin 84 → Fin 84 → ℝ) :
    SymmetricOn (dsCore (fun _ : ι => (polyGaussCore (d := 84)))) (qgFibredDensityHam bg Qb) := dsOp_symmetricOn _ fun _ => qg3DDensity_symmetricOn _ _ _
