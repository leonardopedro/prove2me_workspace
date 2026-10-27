-- Generated from ChapterA1e.lean — solution of BookProof.ChapterA.JY_JY
import Mathlib
import Definitions.Def_ChapterA1e
import Theorems.Thm_BookProof_ChapterA_mem_JY
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (Y : Submodule ℝ V) : JY (JY Y) = Y := by

  refine le_antisymm ?_ ?_ <;> intro x hx <;> simp_all only [mem_JY, Jmap_apply,
      exists_exists_and_eq_and];
  · obtain ⟨ a, ha, rfl ⟩ := hx;
    simp [ ← smul_assoc, ha ];
  · refine ⟨ -x, Y.neg_mem hx, ?_ ⟩ ; simp [ ← smul_assoc ]
