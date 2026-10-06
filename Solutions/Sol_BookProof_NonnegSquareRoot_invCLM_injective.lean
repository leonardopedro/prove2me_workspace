-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.invCLM_injective
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_mem
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
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) : Function.Injective (invCLM hT) := by

  intro a b hab
  have h0 : invCLM hT (a - b) = 0 := by rw [map_sub, hab, sub_self]
  have hmem := invCLM_mem hT (a - b)
  rw [h0] at hmem
  have := hsv _ (by simpa using hmem)
  exact sub_eq_zero.1 this
