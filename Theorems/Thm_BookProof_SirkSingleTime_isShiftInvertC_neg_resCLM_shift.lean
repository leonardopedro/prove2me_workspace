-- Generated from ChapterSirkSingleTimeShift.lean — theorem BookProof.SirkSingleTime.isShiftInvertC_neg_resCLM_shift
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

theorem BookProof.SirkSingleTime.isShiftInvertC_neg_resCLM_shift (T : UnboundedSelfAdjoint E) {l : ℝ} (hl : l ≠ 0) :
    IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) := by sorry
