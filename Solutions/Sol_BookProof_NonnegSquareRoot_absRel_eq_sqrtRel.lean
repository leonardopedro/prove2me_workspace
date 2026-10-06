-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.absRel_eq_sqrtRel
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_eq_sqrtRel_of_isNonnegSelfAdjoint
import Theorems.Thm_BookProof_NonnegSquareRoot_isNonnegSelfAdjoint_factorRel
import Theorems.Thm_BookProof_PositiveSquareRoot_isNonnegSelfAdjoint_absRel
open BookProof.NonnegSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open BookProof.PositiveSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}
variable {a : ℝ}
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) :
    absRel A = sqrtRel (isNonnegSelfAdjoint_factorRel A) := by

  refine eq_sqrtRel_of_isNonnegSelfAdjoint _ (isNonnegSelfAdjoint_absRel A) fun p hp => ?_
  have hmem : p ∈ {q : F × F | ∃ w, (q.1, w) ∈ absRel A ∧ (w, q.2) ∈ absRel A} := hp
  rw [absRel_comp_self A] at hmem
  exact hmem
