-- Generated from ChapterResolventCorrespondence.lean — solution of BookProof.ResolventCorrespondence.singleValued_relOfCLM_iff
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
import Theorems.Thm_BookProof_ResolventCorrespondence_mem_relOfCLM_iff
import Theorems.Thm_BookProof_ResolventCorrespondence_mem_relOfCLM
open BookProof.ResolventCorrespondence




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution :
    (∀ w : F, ((0 : F), w) ∈ relOfCLM R → w = 0) ↔ Function.Injective R := by

  constructor
  · intro hsv y z hyz
    have h0 : R (y - z) = 0 := by rw [map_sub, hyz, sub_self]
    have hmem : ((0 : F), y - z) ∈ relOfCLM R := by
      have := mem_relOfCLM R (y - z)
      rwa [h0, sub_zero] at this
    exact sub_eq_zero.1 (hsv _ hmem)
  · intro hinj w hw
    obtain ⟨y, hy1, hy2⟩ := mem_relOfCLM_iff.1 hw
    simp only at hy1 hy2
    have hy0 : y = 0 := by
      have : R y = R 0 := by rw [hy1, map_zero]
      exact hinj this
    rw [← hy2, hy0, map_zero, sub_zero]
