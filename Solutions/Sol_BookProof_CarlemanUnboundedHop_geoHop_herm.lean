-- Generated from ChapterCarlemanUnboundedHop.lean — solution of BookProof.CarlemanUnboundedHop.geoHop_herm
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
open BookProof.CarlemanUnboundedHop




open Finset

noncomputable section

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (b : ℕ → ℝ) (rho : ℝ) : IsHermitianKernel (geoHop b rho) := by

  intro n k
  by_cases h : n = k
  · subst h; simp [geoHop]
  · rw [geoHop, geoHop, if_neg (Ne.symm h), if_neg h, min_comm k n, max_comm k n,
      Complex.conj_ofReal]
