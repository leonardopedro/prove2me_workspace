-- Generated from ChapterCarlemanUnboundedHop.lean — theorem BookProof.CarlemanUnboundedHop.two_norm_flux_le
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
import Definitions.Def_ChapterA4

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}



open Finset

noncomputable section

theorem BookProof.CarlemanUnboundedHop.two_norm_flux_le (hu : Summable fun n => ‖u n‖ ^ 2)
    (hθ0 : ∀ r, 0 ≤ θ r) (hΘ : ∀ j, HasSum (fun i => θ (i + j + 1)) (Θ j))
    (hA0 : ∀ n, 0 ≤ A n) (hAmono : Monotone A)
    (hbd : ∀ n k, n < k → ‖a n k‖ ≤ A n * θ (k - n)) (N : ℕ) :
    2 * ‖flux a u N‖ ≤ A N * cutMass u Θ N := by sorry
