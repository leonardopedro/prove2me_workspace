-- Generated from ChapterA1e.lean — solution of BookProof.ChapterA.sup_JY_closure_Jinvariant
import Mathlib
import Definitions.Def_ChapterA1e
import Theorems.Thm_BookProof_ChapterA_sup_JY_Jinvariant
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (Y : Submodule ℝ V) :
    ∀ x ∈ (Y ⊔ JY Y).topologicalClosure, Jmap x ∈ (Y ⊔ JY Y).topologicalClosure := by

  intro x hx;
  -- Since $Jmap$ is continuous and $Y ⊔ JY Y$ is $J$-invariant, we have $Jmap x ∈ (Y ⊔ JY
  -- Y).topologicalClosure$.
  have hJmap_cont : Continuous (Jmap : V → V) := by
    exact Jmap.toContinuousLinearEquiv.continuous;
  have hJmap_invariant : ∀ x ∈ Y ⊔ JY Y, Jmap x ∈ Y ⊔ JY Y := sup_JY_Jinvariant Y
  exact mem_closure_image hJmap_cont.continuousAt hx |> fun h => closure_mono (
      Set.image_subset_iff.mpr hJmap_invariant ) h
