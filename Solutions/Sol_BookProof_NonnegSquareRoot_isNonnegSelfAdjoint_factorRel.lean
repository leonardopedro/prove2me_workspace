-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.isNonnegSelfAdjoint_factorRel
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_FriedrichsSquare_adjPairs_factorRel
open BookProof.NonnegSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore
open BookProof.PositiveSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}
variable {a : ℝ}
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) : IsNonnegSelfAdjoint (factorRel A) where
  adj :=
  where
    adj := adjPairs_factorRel A
    nonneg := by
      intro p hp
      obtain ⟨y, -, hval⟩ := inner_fst_add_self hp
      have h1 : (inner ℂ p.1 p.1 : ℂ) = ((‖p.1‖ ^ 2 : ℝ) : ℂ) := by
        rw [inner_self_eq_norm_sq_to_K]; norm_cast
      have h2 : (inner ℂ p.1 p.2 : ℂ) = ((‖y‖ ^ 2 : ℝ) : ℂ) := by
        have hsplit := hval
        rw [inner_add_right, h1] at hsplit
        push_cast at hsplit ⊢
        linear_combination hsplit
      rw [h2, Complex.ofReal_re]
      positivity
