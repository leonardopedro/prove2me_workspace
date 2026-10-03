-- Generated from ChapterCarlemanUnboundedHop.lean — theorem BookProof.CarlemanUnboundedHop.geoHop_norm_off
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
import Definitions.Def_ChapterA4

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}



open Finset

noncomputable section

theorem BookProof.CarlemanUnboundedHop.geoHop_norm_off {b : ℕ → ℝ} {rho : ℝ} (hrho : 0 ≤ rho) {n k : ℕ} (h : n ≠ k) :
    ‖geoHop b rho n k‖ = (1 + ((min n k : ℕ) : ℝ)) * rho ^ (max n k - min n k) := by sorry
