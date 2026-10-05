-- Generated from ChapterNonnegSemigroupGenerator.lean — solution of BookProof.NonnegSemigroupGenerator.tendsto_semigroupS_difference_quotient_at
import Mathlib
import Definitions.Def_ChapterNonnegSemigroupGenerator
import Theorems.Thm_BookProof_NonnegSemigroupGenerator_semigroupS_congr
import Theorems.Thm_BookProof_NonnegSemigroupGenerator_semigroupS_mem_of_mem
import Theorems.Thm_BookProof_NonnegSemigroupGenerator_tendsto_semigroupS_difference_quotient
import Theorems.Thm_BookProof_NonnegSemigroup_semigroupS_add
open BookProof.NonnegSemigroupGenerator




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent BookProof.NonnegUnitaryGroup BookProof.NonnegSemigroup
open Filter Topology NormedSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {h k : F} (hk : (h, k) ∈ T) {t : ℝ} (ht : 0 ≤ t)
    {ε : ℝ} (hε : 0 < ε) :
    ∃ δ > 0, ∀ (u : ℝ) (hu : 0 < u), u < δ →
      ‖u⁻¹ • (semigroupS hT hsv (add_nonneg ht hu.le) h - semigroupS hT hsv ht h)
        + semigroupS hT hsv ht k‖ < ε := by

  obtain ⟨δ, hδ, hbound⟩ :=
    tendsto_semigroupS_difference_quotient hT hsv (semigroupS_mem_of_mem hT hsv hk ht) hε
  refine ⟨δ, hδ, fun u hu huδ => ?_⟩
  have hsplit : semigroupS hT hsv (add_nonneg ht hu.le) h
      = semigroupS hT hsv hu.le (semigroupS hT hsv ht h) := by
    have h1 : semigroupS hT hsv (add_nonneg ht hu.le)
        = semigroupS hT hsv (add_nonneg hu.le ht) :=
      semigroupS_congr hT hsv _ _ (by ring)
    rw [h1, semigroupS_add hT hsv hu.le ht]
    rfl
  rw [hsplit]
  exact hbound u hu huδ
