-- Generated from ChapterCarlemanUnboundedHop.lean — solution of BookProof.CarlemanUnboundedHop.geoHop_norm_off
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
open BookProof.CarlemanUnboundedHop




open Finset

noncomputable section

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {b : ℕ → ℝ} {rho : ℝ} (hrho : 0 ≤ rho) {n k : ℕ} (h : n ≠ k) :
    ‖geoHop b rho n k‖ = (1 + ((min n k : ℕ) : ℝ)) * rho ^ (max n k - min n k) := by

  rw [geoHop, if_neg h, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (by positivity)]
