-- Generated from ChapterNonnegSemigroupGenerator.lean — solution of BookProof.NonnegSemigroupGenerator.norm_semigroupS_sub_semigroupS_le
import Mathlib
import Definitions.Def_ChapterNonnegSemigroupGenerator
import Theorems.Thm_BookProof_NonnegSemigroupGenerator_semigroupS_congr
import Theorems.Thm_BookProof_NonnegSemigroup_norm_semigroupS_apply_le
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
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {s t : ℝ} (hs : 0 ≤ s) (hst : s ≤ t) (x : F) :
    ‖semigroupS hT hsv (hs.trans hst) x - semigroupS hT hsv hs x‖
      ≤ ‖semigroupS hT hsv (sub_nonneg.2 hst) x - x‖ := by

  have hd : (0 : ℝ) ≤ t - s := sub_nonneg.2 hst
  have h1 : semigroupS hT hsv (hs.trans hst)
      = semigroupS hT hsv hs * semigroupS hT hsv hd := by
    rw [← semigroupS_add hT hsv hs hd]
    exact semigroupS_congr hT hsv _ _ (by ring)
  have h2 : semigroupS hT hsv (hs.trans hst) x - semigroupS hT hsv hs x
      = semigroupS hT hsv hs (semigroupS hT hsv hd x - x) := by
    rw [map_sub, h1]
    rfl
  rw [h2]
  exact norm_semigroupS_apply_le hT hsv hs _
