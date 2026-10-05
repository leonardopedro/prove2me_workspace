-- Generated from ChapterCarlemanUnboundedHop.lean — solution of BookProof.CarlemanUnboundedHop.theta_le_Theta
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
open BookProof.CarlemanUnboundedHop




open Finset

noncomputable section

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hθ0 : ∀ r, 0 ≤ θ r)
    (hΘ : ∀ j, HasSum (fun i => θ (i + j + 1)) (Θ j)) (j i : ℕ) : θ (i + j + 1) ≤ Θ j := le_hasSum (hΘ j) i fun _ _ => hθ0 _
