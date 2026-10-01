-- Generated from ChapterQgContinuumModeInstance.lean — theorem BookProof.QgContinuumModeInstance.qgContinuum_ext_core
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterQgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData
open BookProof.QgContinuumModeInstance



open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

theorem BookProof.QgContinuumModeInstance.qgContinuum_ext_core (W : WallPot) (g : ℝ) (p : secCore (ι := CMode)) :
    (secData W (qgContinuumModes g)).ext
        ⟨(p : Sec CMode), (secData W (qgContinuumModes g)).gc.le p.2⟩
      = secHam W (qgContinuumModes g) p := by sorry
