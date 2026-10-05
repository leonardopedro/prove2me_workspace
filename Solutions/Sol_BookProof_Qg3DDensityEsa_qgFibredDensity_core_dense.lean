-- Generated from ChapterQg3DDensityEsa.lean — solution of BookProof.Qg3DDensityEsa.qgFibredDensity_core_dense
import Mathlib
import Definitions.Def_ChapterQg3DDensityEsa
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
theorem solution {ι : Type*} :
    Dense ((dsCore (fun _ : ι => (polyGaussCore (d := 84))) : Submodule ℂ _) :
      Set (lp (fun _ : ι => L2d 84) 2)) := dsCore_dense fun _ => polyGaussCore_dense
