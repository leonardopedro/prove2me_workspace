-- Generated from ChapterA1e.lean — solution of BookProof.ChapterA.inf_JY_isSubsystem
import Mathlib
import Definitions.Def_ChapterA1e
import Theorems.Thm_BookProof_ChapterA_JY_isClosed
import Theorems.Thm_BookProof_ChapterA_JY_isSubsystem
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (M : System ℂ V) {Y : Submodule ℝ V}
    (hY : (rxSystem M).IsSubsystem Y) : (rxSystem M).IsSubsystem (Y ⊓ JY Y) := by

  refine ⟨ ?_, ?_ ⟩;
  · exact IsClosed.inter hY.1 ( JY_isClosed hY.1 );
  · exact fun m hm w hw => ⟨ hY.2 m hm w hw.1, JY_isSubsystem M hY |>.2 m hm w hw.2 ⟩
