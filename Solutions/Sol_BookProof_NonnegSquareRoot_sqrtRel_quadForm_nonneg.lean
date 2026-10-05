-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.sqrtRel_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_mem_sqrtRel_iff
import Theorems.Thm_BookProof_NonnegSquareRoot_sqrtC_mul_sqrtB
import Theorems.Thm_BookProof_NonnegSquareRoot_isSelfAdjoint_sqrtC
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
theorem solution (hT : IsNonnegSelfAdjoint T) {p : F × F} (hp : p ∈ sqrtRel hT) :
    0 ≤ (inner ℂ p.2 p.1 : ℂ) := by

  obtain ⟨y, hy1, hy2⟩ := mem_sqrtRel_iff.1 hp
  have hpos : (midOp (invCLM hT)).IsPositive :=
    (ContinuousLinearMap.nonneg_iff_isPositive _).1 (midOp_nonneg _)
  have hmid : sqrtC hT (sqrtB hT y) = midOp (invCLM hT) y := by
    have h : (sqrtC hT * sqrtB hT) y = midOp (invCLM hT) y := by rw [sqrtC_mul_sqrtB]
    exact h
  rw [← hy1, ← hy2, inner_isSelfAdjoint_left (isSelfAdjoint_sqrtC hT), hmid]
  exact hpos.inner_nonneg_right y
