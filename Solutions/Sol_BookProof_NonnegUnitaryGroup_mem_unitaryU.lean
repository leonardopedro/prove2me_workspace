-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.mem_unitaryU
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Theorems.Thm_BookProof_NonnegUnitaryGroup_unitaryU_invCLMAt
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLMAt_eq_of_mem
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLMAt_mem
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
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {h k : F} (hk : (h, k) ∈ T) (t : ℝ) :
    (unitaryU hT hsv t h, unitaryU hT hsv t k) ∈ T := by

  have h1 : (0 : ℝ) < 1 := one_pos
  have hy : invCLMAt hT h1 (h + k) = h := by
    refine invCLMAt_eq_of_mem hT h1 ?_
    have hrw : h + k - ((1 : ℝ) : ℂ) • h = k := by push_cast; module
    rw [hrw]
    exact hk
  have hmem := invCLMAt_mem hT h1 (unitaryU hT hsv t (h + k))
  rw [← unitaryU_invCLMAt hT hsv h1 t (h + k), hy] at hmem
  have hrw2 : unitaryU hT hsv t (h + k) - ((1 : ℝ) : ℂ) • unitaryU hT hsv t h
      = unitaryU hT hsv t k := by
    rw [map_add]
    push_cast
    module
  rwa [hrw2] at hmem
