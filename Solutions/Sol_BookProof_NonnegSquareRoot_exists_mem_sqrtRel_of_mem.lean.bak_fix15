-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.exists_mem_sqrtRel_of_mem
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_mem_sqrtRel_iff
import Theorems.Thm_BookProof_NonnegSquareRoot_sqrtB_sqrtB_apply
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_eq_of_mem
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
theorem solution (hT : IsNonnegSelfAdjoint T) {p : F × F} (hp : p ∈ T) :
    ∃ w, (p.1, w) ∈ sqrtRel hT := by

  have hx : invCLM hT (p.1 + p.2) = p.1 := invCLM_eq_of_mem hT (by simpa using hp)
  refine ⟨sqrtC hT (sqrtB hT (p.1 + p.2)), mem_sqrtRel_iff.2 ⟨sqrtB hT (p.1 + p.2), ?_, rfl⟩⟩
  rw [sqrtB_sqrtB_apply, hx]
