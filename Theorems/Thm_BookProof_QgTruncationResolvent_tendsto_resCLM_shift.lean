-- Generated from ChapterQgTruncationResolvent.lean — theorem BookProof.QgTruncationResolvent.tendsto_resCLM_shift
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
open BookProof.QgTruncationResolvent

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {ι : Type*}
variable (W : WallPot) (Q : QgModeData ι)



open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.QgOuterFockCoreFL BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.QgTruncationResolvent.tendsto_resCLM_shift (T : UnboundedSelfAdjoint F) (S : ℕ → UnboundedSelfAdjoint F)
    {x : F} (hT : x ∈ T.domain) (hS : ∀ n, x ∈ (S n).domain)
    (hconv : Tendsto (fun n => (S n).op ⟨x, hS n⟩) atTop (𝓝 (T.op ⟨x, hT⟩))) :
    Tendsto (fun n => (S n).resCLM 1 (T.shift 1 ⟨x, hT⟩)) atTop
      (𝓝 (T.resCLM 1 (T.shift 1 ⟨x, hT⟩))) := by sorry
