-- Generated from ChapterNonnegSemigroup.lean — solution of BookProof.NonnegSemigroup.isSelfAdjoint_semigroupS
import Mathlib
import Definitions.Def_ChapterNonnegSemigroup
import Theorems.Thm_BookProof_NonnegSemigroup_isSelfAdjoint_approxS
open BookProof.NonnegSemigroup




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegResolvent
open BookProof.NonnegUnitaryGroup
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {t : ℝ} (ht : 0 ≤ t) :
    IsSelfAdjoint (semigroupS hT hsv ht) := by

  rw [ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric]
  intro x y
  have hx := (tendsto_semigroupS hT hsv ht x).inner (𝕜 := ℂ) (tendsto_const_nhds (x := y))
  have hy := (tendsto_const_nhds (x := x)).inner (𝕜 := ℂ) (tendsto_semigroupS hT hsv ht y)
  refine tendsto_nhds_unique hx ?_
  have heq : (fun n : ℕ => (inner ℂ (approxS hT n t x) y : ℂ))
      = fun n : ℕ => (inner ℂ x (approxS hT n t y) : ℂ) := by
    funext n
    exact (ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.1 (isSelfAdjoint_approxS hT n t)) x y
  rw [heq]
  exact hy
