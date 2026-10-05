-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.norm_sq_eq_inner_of_mem
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_inner_eq_norm_sq_of_mem
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
    (hsv : ∀ v : F, ((0 : F), v) ∈ T → v = 0) {x z w : F} (hz : (x, z) ∈ T)
    (hw : (x, w) ∈ sqrtRel hT) : ‖w‖ ^ 2 = (inner ℂ x z : ℂ).re := by

  rw [inner_eq_norm_sq_of_mem hT hsv hz hw, Complex.ofReal_re]
