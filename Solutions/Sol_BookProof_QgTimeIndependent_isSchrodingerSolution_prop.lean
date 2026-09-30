-- Generated from ChapterQgTimeIndependentFlow.lean — solution of BookProof.QgTimeIndependent.isSchrodingerSolution_prop
import Mathlib
import Definitions.Def_ChapterQgTimeIndependentFlow
import Theorems.Thm_BookProof_QgTimeIndependent_hasDerivAt_prop
open BookProof.QgTimeIndependent









open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint E) (s : ℝ) (x : T.domain) :
    IsSchrodingerSolution T (fun r : ℝ => prop T r s (x : E)) := by

  refine ⟨fun r => T.stoneU_mem_domain (r - s) x, fun r => ?_⟩
  have h := hasDerivAt_prop T x r s
  exact h
