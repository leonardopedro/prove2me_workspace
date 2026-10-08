-- Generated from ChapterCarlemanUnboundedHop.lean — theorem BookProof.CarlemanUnboundedHop.summable_cutMass
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
open BookProof.CarlemanUnboundedHop



open Finset

noncomputable section

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}

theorem BookProof.CarlemanUnboundedHop.summable_cutMass (hu : Summable fun n => ‖u n‖ ^ 2) (hΘ0 : ∀ j, 0 ≤ Θ j)
    (hΘsum : Summable Θ) : Summable (fun N => cutMass u Θ N) := by sorry
