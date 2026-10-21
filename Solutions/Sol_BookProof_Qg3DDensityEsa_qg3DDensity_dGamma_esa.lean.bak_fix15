-- Generated from ChapterQg3DDensityEsa.lean — solution of BookProof.Qg3DDensityEsa.qg3DDensity_dGamma_esa
import Mathlib
import Definitions.Def_ChapterQg3DDensityEsa
import Theorems.Thm_BookProof_Qg3DDensityEsa_qg3DDensity_esa
import Theorems.Thm_BookProof_Qg3DDensityEsa_qg3DDensity_symmetricOn
import Theorems.Thm_BookProof_EsaOneParticle_dGamma_essentiallySelfAdjointOn_of_esa
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
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore (L2dSpace 84) (polyGaussCore (d := 84))
        (polyGaussCore (d := 84)) n))
      (dGammaCoreOp (L2dSpace 84) (polyGaussCore (d := 84))
        (qg3DDensityHam e chi Qb) (polyGaussCore (d := 84))) :=
  EsaOneParticle.dGamma_essentiallySelfAdjointOn_of_esa (Hs := L2dSpace 84)
      (qg3DDensityHam e chi Qb) polyGaussCore_dense (qg3DDensity_symmetricOn e chi Qb)
      (qg3DDensity_esa e chi Qb)
