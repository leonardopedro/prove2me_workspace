-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.inner_mem_conj_eq
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Theorems.Thm_BookProof_PositiveSquareRoot_symm_inner
open BookProof.NonnegUnitaryGroup




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {B C : F →L[ℂ] F} {s t : ℝ}
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) {x y : F} (hxy : (x, y) ∈ T) :
    (starRingEnd ℂ) ⟪x, y⟫_ℂ = ⟪x, y⟫_ℂ := by

  have h := symm_inner hT hxy hxy
  simpa [inner_conj_symm] using h
