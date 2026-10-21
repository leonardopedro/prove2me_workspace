-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.existsUnique_smul_add_mem
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLMAt_mem
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLMAt_eq_of_mem
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

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (h : F) :
    ∃! x : F, (x, h - (a : ℂ) • x) ∈ T :=
  ⟨invCLMAt hT ha h, invCLMAt_mem hT ha h, fun x hx => by
      rw [← invCLMAt_eq_of_mem hT ha hx]⟩
