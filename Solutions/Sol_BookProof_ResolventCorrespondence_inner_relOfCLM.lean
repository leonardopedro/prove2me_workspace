-- Generated from ChapterResolventCorrespondence.lean — solution of BookProof.ResolventCorrespondence.inner_relOfCLM
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
import Theorems.Thm_BookProof_ResolventCorrespondence_isSelfAdjoint_of_nonneg
import Theorems.Thm_BookProof_ResolventCorrespondence_mem_relOfCLM_iff
import Theorems.Thm_BookProof_ResolventCorrespondence_mul_one_sub_eq_midOp_sq
open BookProof.ResolventCorrespondence




open BookProof.ClosureUniqueness BookProof.UnboundedPolar BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (h0 : 0 ≤ R) (h1 : R ≤ 1) {p : F × F} (hp : p ∈ relOfCLM R) :
    (inner ℂ p.1 p.2 : ℂ) = ((‖midOp R (p.1 + p.2)‖ ^ 2 : ℝ) : ℂ) := by

  obtain ⟨y, hy1, hy2⟩ := mem_relOfCLM_iff.1 hp
  have hR : IsSelfAdjoint R := isSelfAdjoint_of_nonneg h0
  have hM : IsSelfAdjoint (midOp R) := isSelfAdjoint_of_nonneg (midOp_nonneg R)
  have hkey : (inner ℂ (R y) (y - R y) : ℂ) = ((‖midOp R y‖ ^ 2 : ℝ) : ℂ) := by
    have happ : (R * (1 - R)) y = R (y - R y) := by
      simp [ContinuousLinearMap.mul_apply]
    have h2 : (inner ℂ (R y) (y - R y) : ℂ) = inner ℂ y ((R * (1 - R)) y) := by
      rw [happ]
      exact inner_isSelfAdjoint_left hR y (y - R y)
    rw [h2, mul_one_sub_eq_midOp_sq h0 h1]
    have h3 : ((midOp R * midOp R : F →L[ℂ] F)) y = midOp R (midOp R y) := rfl
    rw [h3, ← inner_isSelfAdjoint_left hM y (midOp R y), inner_self_eq_norm_sq_to_K]
    norm_cast
  have hsum : R y + (y - R y) = y := by abel
  rw [← hy1, ← hy2, hsum]
  exact hkey
