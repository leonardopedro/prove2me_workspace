-- Generated from ChapterQgManifoldModeInstance.lean — theorem BookProof.QgManifoldModeInstance.ofSpectrumSeq_Amat
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Mathlib
import Definitions.Def_ChapterQgManifoldModeInstance
import Definitions.Def_ChapterA4

variable {ι : Type*}
variable (S : VielbeinSpectrum ι)



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge

noncomputable section


theorem BookProof.QgManifoldModeInstance.ofSpectrumSeq_Amat (mu : ℕ → ℝ) (hmu : ∀ a, 0 ≤ mu a) (a : ℕ) :
    (ofSpectrumSeq mu hmu).Amat a a = ((mu a : ℝ) : ℂ) := by sorry
