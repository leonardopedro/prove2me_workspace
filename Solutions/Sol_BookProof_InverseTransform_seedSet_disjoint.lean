-- Generated from ChapterInverseTransform.lean — solution of BookProof.InverseTransform.seedSet_disjoint
import Mathlib
import Definitions.Def_ChapterInverseTransform
import Theorems.Thm_BookProof_InverseTransform_cdf_monotone
open BookProof.InverseTransform




open MeasureTheory Set Function

variable {n : ℕ} (p : ℕ → ℝ)

variable {n : ℕ} (p : ℕ → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (hp : ∀ i, 0 ≤ p i) :
    Pairwise (Disjoint on seedSet p) := (cdf_monotone p hp).pairwise_disjoint_on_Ico_succ
