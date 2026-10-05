-- Generated from ChapterNonnegSemigroupGenerator.lean — solution of BookProof.NonnegSemigroupGenerator.semigroupS_invCLMAt_comm
import Mathlib
import Definitions.Def_ChapterNonnegSemigroupGenerator
import Theorems.Thm_BookProof_NonnegSemigroupGenerator_commute_approxS_invCLMAt
open BookProof.NonnegSemigroupGenerator




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent BookProof.NonnegUnitaryGroup BookProof.NonnegSemigroup
open Filter Topology NormedSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {t : ℝ} (ht : 0 ≤ t) {b : ℝ} (hb : 0 < b) (y : F) :
    semigroupS hT hsv ht (invCLMAt hT hb y) = invCLMAt hT hb (semigroupS hT hsv ht y) := by

  refine tendsto_nhds_unique (tendsto_semigroupS hT hsv ht (invCLMAt hT hb y)) ?_
  have h1 : ∀ n : ℕ, approxS hT n t (invCLMAt hT hb y)
      = invCLMAt hT hb (approxS hT n t y) := by
    intro n
    have := congrArg (fun S : F →L[ℂ] F => S y) (commute_approxS_invCLMAt hT n t hb)
    simpa [ContinuousLinearMap.mul_apply] using this
  simp only [h1]
  exact ((invCLMAt hT hb).continuous.tendsto _).comp (tendsto_semigroupS hT hsv ht y)
