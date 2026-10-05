-- Generated from ChapterCarlemanUnboundedHop.lean — theorem BookProof.CarlemanUnboundedHop.cutMass_nonneg
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
open BookProof.CarlemanUnboundedHop

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}



open Finset

noncomputable section

theorem BookProof.CarlemanUnboundedHop.cutMass_nonneg (hθ0 : ∀ r, 0 ≤ θ r)
    (hΘ : ∀ j, HasSum (fun i => θ (i + j + 1)) (Θ j)) (N : ℕ) : 0 ≤ cutMass u Θ N := by sorry
