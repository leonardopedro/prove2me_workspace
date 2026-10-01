-- Generated from ChapterQgBrstDerivativeGauge.lean — theorem BookProof.QgBrstDerivativeGauge.brstGaugeFixed_esa
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterQgBrstDerivativeGauge
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterA4
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData



open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

theorem BookProof.QgBrstDerivativeGauge.brstGaugeFixed_esa (W : WallPot) (g : ℝ) :
    EssentiallySelfAdjointOn (secN W (qgContinuumModes g)).dom
      (secData W (qgContinuumModes g)).ext := by sorry
