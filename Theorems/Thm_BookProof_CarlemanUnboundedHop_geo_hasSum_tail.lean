-- Generated from ChapterCarlemanUnboundedHop.lean — theorem BookProof.CarlemanUnboundedHop.geo_hasSum_tail
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
open BookProof.CarlemanUnboundedHop



open Finset

noncomputable section

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}

theorem BookProof.CarlemanUnboundedHop.geo_hasSum_tail {rho : ℝ} (hrho : 0 ≤ rho) (hrho1 : rho < 1) (j : ℕ) :
    HasSum (fun i : ℕ => rho ^ (i + j + 1)) (rho ^ (j + 1) * (1 - rho)⁻¹) := by sorry
