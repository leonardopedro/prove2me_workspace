-- Generated from ChapterCarlemanUnboundedHop.lean — solution of BookProof.CarlemanUnboundedHop.geo_hasSum_tail
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
open BookProof.CarlemanUnboundedHop




open Finset

noncomputable section

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {rho : ℝ} (hrho : 0 ≤ rho) (hrho1 : rho < 1) (j : ℕ) :
    HasSum (fun i : ℕ => rho ^ (i + j + 1)) (rho ^ (j + 1) * (1 - rho)⁻¹) := by

  have h := (hasSum_geometric_of_lt_one hrho hrho1).mul_left (rho ^ (j + 1))
  have heq : (fun i : ℕ => rho ^ (j + 1) * rho ^ i) = fun i : ℕ => rho ^ (i + j + 1) := by
    funext i
    rw [← pow_add]
    congr 1
    omega
  exact heq ▸ h
