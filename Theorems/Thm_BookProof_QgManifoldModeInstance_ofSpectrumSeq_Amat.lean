-- Generated from ChapterQgManifoldModeInstance.lean — theorem BookProof.QgManifoldModeInstance.ofSpectrumSeq_Amat
import Mathlib
import Definitions.Def_ChapterQgManifoldModeInstance
open BookProof.QgManifoldModeInstance

variable {ι : Type*}
variable (S : VielbeinSpectrum ι)



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent
open BookProof.QgTimeStepping

noncomputable section

variable {ι : Type*}

theorem BookProof.QgManifoldModeInstance.ofSpectrumSeq_Amat (mu : ℕ → ℝ) (hmu : ∀ a, 0 ≤ mu a) (a : ℕ) :
    (ofSpectrumSeq mu hmu).Amat a a = ((mu a : ℝ) : ℂ) := by sorry
