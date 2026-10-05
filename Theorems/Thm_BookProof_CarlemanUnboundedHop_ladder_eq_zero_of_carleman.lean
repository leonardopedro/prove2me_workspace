-- Generated from ChapterCarlemanUnboundedHop.lean — theorem BookProof.CarlemanUnboundedHop.ladder_eq_zero_of_carleman
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
open BookProof.CarlemanUnboundedHop

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}



open Finset

noncomputable section

theorem BookProof.CarlemanUnboundedHop.ladder_eq_zero_of_carleman {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {z : ℂ} {A θ Θ : ℕ → ℝ}
    (hz : z.im ≠ 0) (hherm : IsHermitianKernel a) (hrec : LadderRecInf a u z)
    (hu : Summable fun n => ‖u n‖ ^ 2) (hθ0 : ∀ r, 0 ≤ θ r)
    (hΘ : ∀ j, HasSum (fun i => θ (i + j + 1)) (Θ j)) (hΘsum : Summable Θ)
    (hApos : ∀ n, 0 < A n) (hAmono : Monotone A)
    (hbd : ∀ n k, n < k → ‖a n k‖ ≤ A n * θ (k - n))
    (hcar : ¬ Summable fun n => (A n)⁻¹) :
    ∀ n, u n = 0 := by sorry
