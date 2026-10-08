-- Generated from ChapterQgManifoldModeInstance.lean — theorem BookProof.QgManifoldModeInstance.VielbeinSpectrum.energyWindow_exhausts
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterQgTimeStepping
import Mathlib
import Definitions.Def_ChapterQgManifoldModeInstance
open BookProof.QgManifoldModeInstance
open BookProof.QgManifoldModeInstance



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent
open BookProof.QgTimeStepping

noncomputable section

variable {ι : Type*}

variable (S : VielbeinSpectrum ι)

theorem BookProof.QgManifoldModeInstance.VielbeinSpectrum.energyWindow_exhausts (F : Finset ι) :
    ∀ᶠ n : ℕ in atTop, ∀ a ∈ F, a ∈ S.energyWindow n := by sorry
