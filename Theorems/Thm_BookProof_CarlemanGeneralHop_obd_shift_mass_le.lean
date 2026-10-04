-- Generated from ChapterCarlemanGeneralHop.lean — theorem BookProof.CarlemanGeneralHop.obd_shift_mass_le
import Definitions.Def_ChapterHermiteCarlemanEsa
import Mathlib
import Definitions.Def_ChapterCarlemanGeneralHop
import Definitions.Def_ChapterA4
open BookProof.CarlemanGeneralHop

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}



open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section


theorem BookProof.CarlemanGeneralHop.obd_shift_mass_le {B : ℝ} (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B)
    (p m : Fin d →₀ ℕ) (hp : ∀ k, p k ≤ 2) (M : ℕ) :
    ∑ N ∈ Finset.range M, ∑ a ∈ obd d N p m, ‖u (hshift p m a)‖ ^ 2 ≤ 2 * B := by sorry
