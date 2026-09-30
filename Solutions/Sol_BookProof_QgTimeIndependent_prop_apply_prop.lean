-- Generated from ChapterQgTimeIndependentFlow.lean — solution of BookProof.QgTimeIndependent.prop_apply_prop
import Mathlib
import Definitions.Def_ChapterQgTimeIndependentFlow
open BookProof.QgTimeIndependent









open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint E) (t s r : ℝ) (x : E) :
    prop T t s (prop T s r x) = prop T t r x := by

  have h : (t - s) + (s - r) = t - r := by ring
  simp only [prop_apply]
  rw [T.stoneU_apply_stoneU, h]
