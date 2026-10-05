-- Generated from ChapterQgSymmetricSector.lean — theorem BookProof.QgSymmetricSector.qgFull_bosonic_core_esa
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
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterScalaronFiberFL
import Mathlib
import Definitions.Def_ChapterQgSymmetricSector
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
open BookProof.DirectSumEsa
open BookProof.QgSymmetricSector



open scoped TensorProduct
open BookProof.ScalaronOuterFockFL BookProof.QgVielbeinModeInstance
open BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.FockStatistics
open BookProof.PermSector BookProof.ReducedEsa BookProof.GroupAverage BookProof.TensorPerm
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore BookProof.ScalaronFiberFL

noncomputable section

theorem BookProof.QgSymmetricSector.qgFull_bosonic_core_esa (W : WallPot) (g : ℝ) (n : ℕ) :
    EssentiallySelfAdjointOn
      (redDom (bosonicProj qgSecSpace n)
        (sectorCore qgSecSpace (secCore (ι := by sorry
