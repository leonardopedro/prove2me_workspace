-- Generated from ChapterCarlemanGeneralHop.lean — solution of BookProof.CarlemanGeneralHop.obd_mass_le
import Mathlib
import Definitions.Def_ChapterCarlemanGeneralHop
import Theorems.Thm_BookProof_CarlemanGeneralHop_obd_multiplicity
import Theorems.Thm_BookProof_CarlemanTwoStep_sum_range_of_multiplicity
open BookProof.CarlemanGeneralHop




open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution {B : ℝ} (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B)
    (p m : Fin d →₀ ℕ) (hp : ∀ k, p k ≤ 2) (M : ℕ) :
    ∑ N ∈ Finset.range M, ∑ a ∈ obd d N p m, ‖u a‖ ^ 2 ≤ 2 * B := by

  have := CarlemanTwoStep.sum_range_of_multiplicity (u := u) 2 hbes
    (fun N => obd d N p m) (obd_multiplicity p m hp) M
  simpa using this
