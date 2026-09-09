-- Generated from ChapterSirkSingleTimeShift.lean — theorem BookProof.SirkSingleTime.norm_neg_resCLM_apply_le
import Mathlib
import Definitions.Def_ChapterSirkSingleTimeShift
open BookProof.SirkSingleTime








open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]






variable {T : UnboundedSelfAdjoint E} {S : ℕ → UnboundedSelfAdjoint E}

theorem BookProof.SirkSingleTime.norm_neg_resCLM_apply_le (T : UnboundedSelfAdjoint E) (l : ℝ) (y : E) :
    ‖(-(T.resCLM l)) y‖ ≤ (1 / |l|) * ‖y‖ := by sorry
