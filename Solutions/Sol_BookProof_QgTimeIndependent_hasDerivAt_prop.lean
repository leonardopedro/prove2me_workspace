-- Generated from ChapterQgTimeIndependentFlow.lean — solution of BookProof.QgTimeIndependent.hasDerivAt_prop
import Mathlib
import Definitions.Def_ChapterQgTimeIndependentFlow
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_hasDerivAt_stoneU_op
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_mem_domain
open BookProof.QgTimeIndependent




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint E) (x : T.domain) (t s : ℝ) :
    HasDerivAt (fun r : ℝ => prop T r s (x : E))
      ((-Complex.I) • T.op ⟨T.stoneU (t - s) (x : E), T.stoneU_mem_domain (t - s) x⟩) t := by

  have h := T.hasDerivAt_stoneU_op x (t - s)
  exact h.comp_sub_const t s
