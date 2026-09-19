-- Generated from ChapterQg3DGaugeEsa.lean — solution of BookProof.Qg3DGaugeEsa.qg3D_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterQg3DGaugeEsa
import Theorems.Thm_BookProof_Qg3DGaugeEsa_qgSigned_essentiallySelfAdjointOn_core
open BookProof.Qg3DGaugeEsa




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.QuantumGravity3DGauge
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
_essentiallySelfAdjoint (qgFqP kappa) qgFqQ 0 0 0

theorem solution :
    EssentiallySelfAdjointOn (polyGauss := Core (d := 84)) (qg3DHamiltonian (coreRepPoly 84))
