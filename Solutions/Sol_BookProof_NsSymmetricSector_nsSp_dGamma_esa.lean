-- Generated from ChapterNsSymmetricSector.lean — solution of BookProof.NsSymmetricSector.nsSp_dGamma_esa
import Mathlib
import Definitions.Def_ChapterNsSymmetricSector
import Theorems.Thm_BookProof_NsSymmetricSector_nsSpOp_symmetricOn
import Theorems.Thm_BookProof_NsSymmetricSector_nsSpOp_esa
import Theorems.Thm_BookProof_EsaOneParticle_dGamma_essentiallySelfAdjointOn_of_esa
open BookProof.NsSymmetricSector




open scoped TensorProduct
open BookProof.NsOneBody BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.GraphCore
open BookProof.TensorCore BookProof.FockStatistics BookProof.PermSector BookProof.ReducedEsa
open BookProof.GroupAverage BookProof.TensorPerm
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) :
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore (L2dSpace 6) (polyGaussCore (d := 6))
        (polyGaussCore (d := 6)) n))
      (dGammaCoreOp (L2dSpace 6) (polyGaussCore (d := 6)) (nsSpOp nu k)
        (polyGaussCore (d := 6))) :=
  EsaOneParticle.dGamma_essentiallySelfAdjointOn_of_esa (Hs := L2dSpace 6) (nsSpOp nu k)
      polyGaussCore_dense (nsSpOp_symmetricOn nu k) (nsSpOp_esa nu k)
