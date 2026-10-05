-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.eq_sqrtRel_of_isNonnegSelfAdjoint
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_isNonnegSelfAdjoint_sqrtRel
import Theorems.Thm_BookProof_NonnegSquareRoot_sqrtRel_comp_self
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLM_eq_cfc_of_sq
import Theorems.Thm_BookProof_PositiveSquareRoot_rel_eq_of_invCLM_eq
open BookProof.NonnegSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore
open BookProof.PositiveSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hS : IsNonnegSelfAdjoint S)
    (hsq : ∀ p : F × F, (∃ w, (p.1, w) ∈ S ∧ (w, p.2) ∈ S) → p ∈ T) :
    S = sqrtRel hT := by

  have hroot : ∀ p : F × F,
      (∃ w, (p.1, w) ∈ sqrtRel hT ∧ (w, p.2) ∈ sqrtRel hT) → p ∈ T := by
    intro p hp
    have hmem : p ∈ {q : F × F | ∃ w, (q.1, w) ∈ sqrtRel hT ∧ (w, q.2) ∈ sqrtRel hT} := hp
    rw [sqrtRel_comp_self hT] at hmem
    exact hmem
  exact rel_eq_of_invCLM_eq hS (isNonnegSelfAdjoint_sqrtRel hT)
    ((invCLM_eq_cfc_of_sq hT hS hsq).trans
      (invCLM_eq_cfc_of_sq hT (isNonnegSelfAdjoint_sqrtRel hT) hroot).symm)
