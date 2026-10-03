-- Generated from ChapterCarlemanUnboundedHop.lean — theorem BookProof.CarlemanUnboundedHop.geoHop_bound
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
import Definitions.Def_ChapterA4

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}



open Finset

noncomputable section

theorem BookProof.CarlemanUnboundedHop.geoHop_bound {b : ℕ → ℝ} {rho : ℝ} (hrho : 0 ≤ rho) (n k : ℕ) (hnk : n < k) :
    ‖geoHop b rho n k‖ ≤ (1 + (n : ℝ)) * rho ^ (k - n) := by sorry
