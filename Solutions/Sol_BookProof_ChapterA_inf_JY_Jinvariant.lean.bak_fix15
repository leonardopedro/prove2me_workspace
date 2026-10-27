-- Generated from ChapterA1e.lean — solution of BookProof.ChapterA.inf_JY_Jinvariant
import Mathlib
import Definitions.Def_ChapterA1e
import Theorems.Thm_BookProof_ChapterA_Jmap_mem_JY
import Theorems.Thm_BookProof_ChapterA_Jmap_mem_of_mem_JY
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (Y : Submodule ℝ V) :
    ∀ x ∈ Y ⊓ JY Y, Jmap x ∈ Y ⊓ JY Y := by

  simp? +zetaDelta at *;
  exact fun x hx₁ hx₂ => ⟨ Jmap_mem_of_mem_JY hx₂, Jmap_mem_JY hx₁ ⟩
