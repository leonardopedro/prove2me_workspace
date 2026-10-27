-- Generated from ChapterA1d.lean — solution of BookProof.ChapterA.Jmap_isRImaginary
import Mathlib
import Definitions.Def_ChapterA1d
import Theorems.Thm_BookProof_ChapterA_Jmap_sq
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace




attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace V] (M : System ℂ V) :
    IsRImaginary (rxSystem M) Jmap := by

  refine ⟨Jmap_sq, ?_⟩
  rintro _ ⟨m, hm, rfl⟩ x
  change (Complex.I : ℂ) • (m x) = m ((Complex.I : ℂ) • x)
  rw [map_smul]
