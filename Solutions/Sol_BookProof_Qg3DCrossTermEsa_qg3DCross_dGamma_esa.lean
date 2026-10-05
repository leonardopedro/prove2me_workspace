-- Generated from ChapterQg3DCrossTermEsa.lean — solution of BookProof.Qg3DCrossTermEsa.qg3DCross_dGamma_esa
import Mathlib
import Definitions.Def_ChapterQg3DCrossTermEsa
import Theorems.Thm_BookProof_Qg3DCrossTermEsa_qg3DCross_esa
import Theorems.Thm_BookProof_Qg3DCrossTermEsa_qg3DCross_symmetricOn
import Theorems.Thm_BookProof_EsaOneParticle_dGamma_essentiallySelfAdjointOn_of_esa
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
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore (L2dSpace 84) (polyGaussCore (d := 84))
        (polyGaussCore (d := 84)) n))
      (dGammaCoreOp (L2dSpace 84) (polyGaussCore (d := 84))
        (qg3DCrossHamiltonian Q') (polyGaussCore (d := 84))) :=
  EsaOneParticle.dGamma_essentiallySelfAdjointOn_of_esa (Hs := L2dSpace 84)
      (qg3DCrossHamiltonian Q') polyGaussCore_dense (qg3DCross_symmetricOn Q')
      (qg3DCross_esa Q')
