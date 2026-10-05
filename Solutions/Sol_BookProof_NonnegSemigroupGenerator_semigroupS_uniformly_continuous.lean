-- Generated from ChapterNonnegSemigroupGenerator.lean — solution of BookProof.NonnegSemigroupGenerator.semigroupS_uniformly_continuous
import Mathlib
import Definitions.Def_ChapterNonnegSemigroupGenerator
import Theorems.Thm_BookProof_NonnegSemigroupGenerator_norm_semigroupS_sub_semigroupS_le
import Theorems.Thm_BookProof_NonnegSemigroup_tendsto_semigroupS_zero
open BookProof.NonnegSemigroupGenerator




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent BookProof.NonnegUnitaryGroup BookProof.NonnegSemigroup
open Filter Topology NormedSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (x : F) {ε : ℝ} (hε : 0 < ε) :
    ∃ δ > 0, ∀ (s t : ℝ) (hs : 0 ≤ s) (ht : 0 ≤ t), |t - s| < δ →
      ‖semigroupS hT hsv ht x - semigroupS hT hsv hs x‖ < ε := by

  obtain ⟨δ, hδ, hbound⟩ := tendsto_semigroupS_zero hT hsv x hε
  refine ⟨δ, hδ, fun s t hs ht habs => ?_⟩
  rcases le_total s t with hst | hts
  · have hd : |t - s| = t - s := abs_of_nonneg (sub_nonneg.2 hst)
    have h1 := norm_semigroupS_sub_semigroupS_le hT hsv hs hst x
    have h2 := hbound (t - s) (sub_nonneg.2 hst) (by rw [hd] at habs; exact habs)
    calc ‖semigroupS hT hsv ht x - semigroupS hT hsv hs x‖
        = ‖semigroupS hT hsv (hs.trans hst) x - semigroupS hT hsv hs x‖ := rfl
      _ ≤ ‖semigroupS hT hsv (sub_nonneg.2 hst) x - x‖ := h1
      _ < ε := h2
  · have hd : |t - s| = s - t := by
      rw [abs_of_nonpos (by linarith)]; ring
    have h1 := norm_semigroupS_sub_semigroupS_le hT hsv ht hts x
    have h2 := hbound (s - t) (sub_nonneg.2 hts) (by rw [hd] at habs; exact habs)
    rw [norm_sub_rev]
    calc ‖semigroupS hT hsv hs x - semigroupS hT hsv ht x‖
        = ‖semigroupS hT hsv (ht.trans hts) x - semigroupS hT hsv ht x‖ := rfl
      _ ≤ ‖semigroupS hT hsv (sub_nonneg.2 hts) x - x‖ := h1
      _ < ε := h2
