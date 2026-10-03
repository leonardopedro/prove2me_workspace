-- Generated from ChapterQgManifoldModeInstance.lean — theorem BookProof.QgManifoldModeInstance.VielbeinSpectrum.energyWindow_exhausts
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgOuterFockCoreFL
import Mathlib
import Definitions.Def_ChapterQgManifoldModeInstance
import Definitions.Def_ChapterA4

variable {ι : Type*}
variable (S : VielbeinSpectrum ι)



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge

noncomputable section


theorem BookProof.QgManifoldModeInstance.VielbeinSpectrum.energyWindow_exhausts (F : Finset ι) :
    ∀ᶠ n : ℕ in atTop, ∀ a ∈ F, a ∈ S.energyWindow n := by sorry
