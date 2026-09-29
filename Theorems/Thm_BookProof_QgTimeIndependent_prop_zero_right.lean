-- Generated from ChapterQgTimeIndependentFlow.lean — theorem BookProof.QgTimeIndependent.prop_zero_right
import Mathlib
import Definitions.Def_ChapterQgTimeIndependentFlow
open BookProof.QgTimeIndependent








open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

theorem BookProof.QgTimeIndependent.prop_zero_right (T : UnboundedSelfAdjoint E) (t : ℝ) :
    prop T t 0 = T.stoneU t := by sorry
