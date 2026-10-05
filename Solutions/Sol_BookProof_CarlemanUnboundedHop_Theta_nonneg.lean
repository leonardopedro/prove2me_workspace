-- Generated from ChapterCarlemanUnboundedHop.lean — solution of BookProof.CarlemanUnboundedHop.Theta_nonneg
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
import Theorems.Thm_BookProof_CarlemanUnboundedHop_theta_le_Theta
open BookProof.CarlemanUnboundedHop




open Finset

noncomputable section

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hθ0 : ∀ r, 0 ≤ θ r)
    (hΘ : ∀ j, HasSum (fun i => θ (i + j + 1)) (Θ j)) (j : ℕ) : 0 ≤ Θ j := le_trans (hθ0 _) (theta_le_Theta hθ0 hΘ j 0)
