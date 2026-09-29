-- Generated from ChapterQgTimeIndependentFlow.lean — theorem BookProof.QgTimeIndependent.prop_apply_prop
import Mathlib
import Definitions.Def_ChapterQgTimeIndependentFlow
open BookProof.QgTimeIndependent








open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

theorem BookProof.QgTimeIndependent.prop_apply_prop (T : UnboundedSelfAdjoint E) (t s r : ℝ) (x : E) :
    prop T t s (prop T s r x) = prop T t r x := by sorry
