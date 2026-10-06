-- Generated from ChapterResolventCorrespondence.lean — solution of BookProof.ResolventCorrespondence.existsUnique_isNonnegSelfAdjoint_invCLM_eq
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
import Theorems.Thm_BookProof_ResolventCorrespondence_isNonnegSelfAdjoint_relOfCLM
import Theorems.Thm_BookProof_ResolventCorrespondence_invCLM_relOfCLM
import Theorems.Thm_BookProof_PositiveSquareRoot_rel_eq_of_invCLM_eq
open BookProof.ResolventCorrespondence




open BookProof.ClosureUniqueness BookProof.UnboundedPolar BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (h0 : 0 ≤ R) (h1 : R ≤ 1) :
    ∃! T : Submodule ℂ (F × F), ∃ hT : IsNonnegSelfAdjoint T, invCLM hT = R := by

  refine ⟨relOfCLM R, ⟨isNonnegSelfAdjoint_relOfCLM h0 h1, invCLM_relOfCLM h0 h1⟩, ?_⟩
  rintro S ⟨hS, hSR⟩
  exact rel_eq_of_invCLM_eq hS (isNonnegSelfAdjoint_relOfCLM h0 h1)
    (by rw [hSR, invCLM_relOfCLM h0 h1])
