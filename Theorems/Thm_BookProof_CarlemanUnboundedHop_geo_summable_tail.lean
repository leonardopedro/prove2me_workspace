-- Generated from ChapterCarlemanUnboundedHop.lean — theorem BookProof.CarlemanUnboundedHop.geo_summable_tail
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
import Definitions.Def_ChapterA4

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}



open Finset

noncomputable section

theorem BookProof.CarlemanUnboundedHop.geo_summable_tail {rho : ℝ} (hrho : 0 ≤ rho) (hrho1 : rho < 1) :
    Summable (fun j : ℕ => rho ^ (j + 1) * (1 - rho)⁻¹) := by sorry
