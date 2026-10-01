-- Generated from ChapterQgBrstDerivativeGauge.lean — theorem BookProof.QgBrstDerivativeGauge.restrict_essentiallySelfAdjointOn
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

theorem BookProof.QgBrstDerivativeGauge.restrict_essentiallySelfAdjointOn {ι : Type*} (W : WallPot) (Q : QgModeData ι)
    (s : Set ι) :
    EssentiallySelfAdjointOn (secN W (restrictModes Q s)).dom
      (secData W (restrictModes Q s)).ext := by sorry
