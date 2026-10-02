-- Generated from ChapterQgManifoldModeInstance.lean — solution of BookProof.QgManifoldModeInstance.ofSpectrumSeq_Amat
import Mathlib
import Definitions.Def_ChapterQgManifoldModeInstance




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge

noncomputable section

variable {ι : Type*}

variable {ι : Type*}
variable (S : VielbeinSpectrum ι)

set_option maxHeartbeats 1000000 in
theorem solution (mu : ℕ → ℝ) (hmu : ∀ a, 0 ≤ mu a) (a : ℕ) :
    (ofSpectrumSeq mu hmu).Amat a a = ((mu a : ℝ) : ℂ) := by

  simp [VielbeinSpectrum.Amat, ofSpectrumSeq]
