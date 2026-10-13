-- Generated from ChapterQgSymmetricSector.lean — solution of BookProof.QgSymmetricSector.qgFull_bosonicFock_esa
import Mathlib
import Definitions.Def_ChapterQgSymmetricSector
import Theorems.Thm_BookProof_QgSymmetricSector_qgFullOp_symmetricOn
import Theorems.Thm_BookProof_QgSymmetricSector_qgFullOp_esa
import Theorems.Thm_BookProof_FockStatistics_bosonicFock_esa
import Theorems.Thm_BookProof_QgTruncationResolvent_secCore_dense
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgVielbeinModeInstance
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterTensorPermutation
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterFarisLavineCore
open BookProof.QgSymmetricSector




open scoped TensorProduct
open BookProof.ScalaronOuterFockFL BookProof.QgVielbeinModeInstance
open BookProof.QgContinuumModeInstance BookProof.QgVielbeinScalaronGaugeFL
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.FockStatistics
open BookProof.PermSector BookProof.ReducedEsa BookProof.GroupAverage BookProof.TensorPerm
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore BookProof.ScalaronFiberFL

noncomputable section

set_option maxHeartbeats 1000000 in

theorem solution (W : WallPot) (g : ℝ) :
    EssentiallySelfAdjointOn (bosonicFockDom qgSecSpace (secCore (ι := GMode)))
      (bosonicFockOp qgSecSpace (secCore (ι := GMode)) (qgFullOp W g)) :=
  bosonicFock_esa (Hs := qgSecSpace) (qgFullOp W g) secCore_dense
    (qgFullOp_symmetricOn W g) (qgFullOp_esa W g)
