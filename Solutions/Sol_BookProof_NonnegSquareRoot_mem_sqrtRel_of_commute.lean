-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.mem_sqrtRel_of_commute
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_mem_sqrtRel_iff
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_nonneg
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
theorem solution (hT : IsNonnegSelfAdjoint T) {B : F →L[ℂ] F}
    (hB : Commute (invCLM hT) B) {p : F × F} (hp : p ∈ sqrtRel hT) :
    (B p.1, B p.2) ∈ sqrtRel hT := by

  obtain ⟨y, hy1, hy2⟩ := mem_sqrtRel_iff.1 hp
  have hsa : IsSelfAdjoint (invCLM hT) := (invCLM_nonneg hT).isSelfAdjoint
  have h1 : Commute (sqrtB hT) B := hsa.commute_cfc (𝕜 := ℝ) hB Real.sqrt
  have h2 : Commute (sqrtC hT) B := hsa.commute_cfc (𝕜 := ℝ) hB fun t => Real.sqrt (1 - t)
  refine mem_sqrtRel_iff.2 ⟨B y, ?_, ?_⟩
  · have := congrArg (fun S : F →L[ℂ] F => S y) h1
    simp only [ContinuousLinearMap.mul_apply] at this
    rw [this, hy1]
  · have := congrArg (fun S : F →L[ℂ] F => S y) h2
    simp only [ContinuousLinearMap.mul_apply] at this
    rw [this, hy2]
