-- Generated from ChapterNsSymmetricSector.lean — solution of BookProof.NsSymmetricSector.nsSp_bosonic_core_esa
import Mathlib
import Definitions.Def_ChapterNsSymmetricSector
import Theorems.Thm_BookProof_NsSymmetricSector_nsSpOp_symmetricOn
import Theorems.Thm_BookProof_NsSymmetricSector_nsSpOp_esa
import Theorems.Thm_BookProof_FockStatistics_essentiallySelfAdjointOn_bosonic_core_of_esa
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
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) :
    EssentiallySelfAdjointOn
      (redDom (bosonicProj (L2dSpace 6) n)
        (sectorCore (L2dSpace 6) (polyGaussCore (d := 6)) (polyGaussCore (d := 6)) n))
      (bosonicCoreOp (L2dSpace 6) (polyGaussCore (d := 6)) (nsSpOp nu k)
        (polyGaussCore (d := 6)) n) :=
  essentiallySelfAdjointOn_bosonic_core_of_esa (Hs := L2dSpace 6) (nsSpOp nu k)
      polyGaussCore_dense (nsSpOp_symmetricOn nu k) (nsSpOp_esa nu k) (IsGraphCore.refl _) n
