-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.mem_of_commute
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_eq_of_mem
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_mem
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
theorem solution (hT : IsNonnegSelfAdjoint T) {B : F →L[ℂ] F}
    (hB : Commute (invCLM hT) B) {p : F × F} (hp : p ∈ T) : (B p.1, B p.2) ∈ T := by

  have hx : invCLM hT (p.1 + p.2) = p.1 := invCLM_eq_of_mem hT (by simpa using hp)
  have hBx : invCLM hT (B p.1 + B p.2) = B p.1 := by
    have hcomm : (invCLM hT * B) (p.1 + p.2) = (B * invCLM hT) (p.1 + p.2) := by rw [hB]
    simp only [ContinuousLinearMap.mul_apply] at hcomm
    rw [← map_add, hcomm, hx]
  have hmem := invCLM_mem hT (B p.1 + B p.2)
  rw [hBx] at hmem
  simpa using hmem
