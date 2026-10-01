-- Generated from ChapterQgContinuumModeInstance.lean — theorem BookProof.QgContinuumModeInstance.qgContinuum_essentiallySelfAdjointOn
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterA4
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData



open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

theorem BookProof.QgContinuumModeInstance.qgContinuum_essentiallySelfAdjointOn (W : WallPot) (g : ℝ) :
    EssentiallySelfAdjointOn (secN W (qgContinuumModes g)).dom
      (secData W (qgContinuumModes g)).ext := by sorry
