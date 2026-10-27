-- Generated from ChapterNonnegSemigroupGenerator.lean — solution of BookProof.NonnegSemigroupGenerator.semigroupS_mem_of_mem
import Mathlib
import Definitions.Def_ChapterNonnegSemigroupGenerator
import Theorems.Thm_BookProof_NonnegSemigroupGenerator_semigroupS_invCLMAt_comm
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLMAt_eq_of_mem
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLMAt_mem
open BookProof.NonnegSemigroupGenerator




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent BookProof.NonnegUnitaryGroup BookProof.NonnegSemigroup
open Filter Topology NormedSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {h k : F} (hk : (h, k) ∈ T) {t : ℝ} (ht : 0 ≤ t) :
    (semigroupS hT hsv ht h, semigroupS hT hsv ht k) ∈ T := by

  have hone : (0 : ℝ) < 1 := one_pos
  set R := invCLMAt hT hone with hR
  have hRh : R (k + h) = h := by
    refine invCLMAt_eq_of_mem hT hone ?_
    simpa using hk
  have hcomm : semigroupS hT hsv ht (R (k + h)) = R (semigroupS hT hsv ht (k + h)) :=
    semigroupS_invCLMAt_comm hT hsv ht hone _
  have hsplit : semigroupS hT hsv ht (k + h)
      = semigroupS hT hsv ht k + semigroupS hT hsv ht h := map_add _ _ _
  have hkey : R (semigroupS hT hsv ht k + semigroupS hT hsv ht h)
      = semigroupS hT hsv ht h := by
    rw [← hsplit, ← hcomm, hRh]
  have hmem := invCLMAt_mem hT hone (semigroupS hT hsv ht k + semigroupS hT hsv ht h)
  rw [← hR, hkey] at hmem
  simpa using hmem
