-- Generated from ChapterQgTimeIndependentFlow.lean — solution of BookProof.QgTimeIndependent.prop_time_translation
import Mathlib
import Definitions.Def_ChapterQgTimeIndependentFlow




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint E) (t s h : ℝ) :
    prop T (t + h) (s + h) = prop T t s := by

  have : t + h - (s + h) = t - s := by ring
  rw [prop, prop, this]
