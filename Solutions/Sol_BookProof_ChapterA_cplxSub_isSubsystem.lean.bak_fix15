-- Generated from ChapterA1d.lean — solution of BookProof.ChapterA.cplxSub_isSubsystem
import Mathlib
import Definitions.Def_ChapterA1d
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace




attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace V] (M : System ℂ V) {Y : Submodule ℝ V}
    (hJ : ∀ y ∈ Y, (Complex.I : ℂ) • y ∈ Y) (hY : (rxSystem M).IsSubsystem Y) :
    (M).IsSubsystem (cplxSub Y hJ) := by

  obtain ⟨hcl, hinv⟩ := hY
  refine ⟨?_, ?_⟩
  · convert hcl using 1 <;> (ext x; simp [mem_cplxSub])
  · intro m hm w hw
    rw [mem_cplxSub] at *
    exact hinv (rxMap m) (Set.mem_image_of_mem _ hm) w hw
