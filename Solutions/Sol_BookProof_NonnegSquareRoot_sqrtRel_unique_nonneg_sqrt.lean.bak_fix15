-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.sqrtRel_unique_nonneg_sqrt
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_isNonnegSelfAdjoint_sqrtRel
import Theorems.Thm_BookProof_NonnegSquareRoot_sqrtRel_comp_self
import Theorems.Thm_BookProof_NonnegSquareRoot_eq_sqrtRel_of_isNonnegSelfAdjoint
open BookProof.NonnegSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open BookProof.PositiveSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) :
    IsNonnegSelfAdjoint (sqrtRel hT) ∧
      {p : F × F | ∃ w, (p.1, w) ∈ sqrtRel hT ∧ (w, p.2) ∈ sqrtRel hT} = (T : Set (F × F)) ∧
      ∀ S : Submodule ℂ (F × F), IsNonnegSelfAdjoint S →
        {p : F × F | ∃ w, (p.1, w) ∈ S ∧ (w, p.2) ∈ S} = (T : Set (F × F)) →
        S = sqrtRel hT := by

  refine ⟨isNonnegSelfAdjoint_sqrtRel hT, sqrtRel_comp_self hT, fun S hS hsq => ?_⟩
  refine eq_sqrtRel_of_isNonnegSelfAdjoint hT hS fun p hp => ?_
  have hmem : p ∈ {q : F × F | ∃ w, (q.1, w) ∈ S ∧ (w, q.2) ∈ S} := hp
  rw [hsq] at hmem
  exact hmem
