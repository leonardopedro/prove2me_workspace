-- Generated from ChapterQgTimeIndependentFlow.lean — theorem BookProof.QgTimeIndependent.norm_prop_apply
import Mathlib
import Definitions.Def_ChapterQgTimeIndependentFlow
open BookProof.QgTimeIndependent








open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

theorem BookProof.QgTimeIndependent.norm_prop_apply (T : UnboundedSelfAdjoint E) (t s : ℝ) (x : E) :
    ‖prop T t s x‖ = ‖x‖ := by sorry
