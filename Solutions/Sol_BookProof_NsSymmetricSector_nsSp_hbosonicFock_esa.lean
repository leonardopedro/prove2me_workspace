-- Generated from ChapterNsSymmetricSector.lean — solution of BookProof.NsSymmetricSector.nsSp_hbosonicFock_esa
import Mathlib
import Definitions.Def_ChapterNsSymmetricSector
import Theorems.Thm_BookProof_NsSymmetricSector_nsSpOp_symmetricOn
import Theorems.Thm_BookProof_NsSymmetricSector_nsSpOp_esa
import Theorems.Thm_BookProof_FockStatistics_hbosonicFock_esa
import Definitions.Def_ChapterNsOneBodyDGamma
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterTensorPermutation
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterTensorGraphCore
open BookProof.NsSymmetricSector




open scoped TensorProduct
open BookProof.NsOneBody BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.GraphCore
open BookProof.TensorCore BookProof.FockStatistics BookProof.PermSector BookProof.ReducedEsa
open BookProof.GroupAverage BookProof.TensorPerm
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa
open BookProof.HermiteProductCore
open BookProof.TensorCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) :
    EssentiallySelfAdjointOn (hbosonicFockDom (L2dSpace 6) (polyGaussCore (d := 6)))
      (hbosonicFockOp (L2dSpace 6) (polyGaussCore (d := 6)) (nsSpOp nu k)) :=
  hbosonicFock_esa (Hs := L2dSpace 6) (nsSpOp nu k) polyGaussCore_dense
      (nsSpOp_symmetricOn nu k) (nsSpOp_esa nu k)
