-- Generated from ChapterCarlemanTwoStep.lean — solution of BookProof.CarlemanTwoStep.shifted_facesK_le
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
import Theorems.Thm_BookProof_CarlemanTwoStep_sum_range_of_multiplicity
import Theorems.Thm_BookProof_CarlemanTwoStep_shiftedK_multiplicity
open BookProof.CarlemanTwoStep




open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {B : ℝ}
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B) (i : Fin d) (k M : ℕ) :
    ∑ N ∈ Finset.range M, ∑ a ∈ faceK d N i k, ‖u (a + Finsupp.single i k)‖ ^ 2
      ≤ (k : ℝ) * B := by

  classical
  have hinj : ∀ N : ℕ, ∑ a ∈ faceK d N i k, ‖u (a + Finsupp.single i k)‖ ^ 2
      = ∑ b ∈ (faceK d N i k).image (fun a => a + Finsupp.single i k), ‖u b‖ ^ 2 := by
    intro N
    rw [Finset.sum_image]
    intro x _ y _ hxy
    exact add_right_cancel hxy
  simp_rw [hinj]
  exact sum_range_of_multiplicity k hbes
    (fun N => (faceK d N i k).image (fun a => a + Finsupp.single i k))
    (shiftedK_multiplicity i k) M
