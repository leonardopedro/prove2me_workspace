-- Generated from ChapterA1d.lean — solution of BookProof.ChapterA.realSub_isSubsystem
import Mathlib
import Definitions.Def_ChapterA1d
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace




attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace V] (M : System ℂ V) {X : Submodule ℂ V}
    (hX : (M).IsSubsystem X) : (rxSystem M).IsSubsystem (realSub X) := by

  obtain ⟨hcl, hinv⟩ := hX
  refine ⟨?_, ?_⟩
  · convert hcl using 1 <;> (ext x; simp [mem_realSub])
  · rintro _ ⟨m, hm, rfl⟩ w hw
    rw [mem_realSub] at *
    exact hinv m hm w hw
