-- Generated from ChapterQgSymmetricSector.lean — theorem BookProof.QgSymmetricSector.qgFull_bosonicFock_esa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterDirectSumEsa
import Mathlib
import Definitions.Def_ChapterQgSymmetricSector
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterA4
open BookProof.QgSymmetricSector



open scoped TensorProduct
open BookProof.ScalaronOuterFockFL BookProof.QgVielbeinModeInstance
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.FockStatistics
open BookProof.PermSector BookProof.ReducedEsa BookProof.GroupAverage BookProof.TensorPerm
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore BookProof.ScalaronFiberFL

noncomputable section

theorem BookProof.QgSymmetricSector.qgFull_bosonicFock_esa (W : WallPot) (g : ℝ) :
    EssentiallySelfAdjointOn (bosonicFockDom qgSecSpace (secCore (ι := by sorry
