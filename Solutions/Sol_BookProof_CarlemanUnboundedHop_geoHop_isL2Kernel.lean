-- Generated from ChapterCarlemanUnboundedHop.lean — solution of BookProof.CarlemanUnboundedHop.geoHop_isL2Kernel
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
import Theorems.Thm_BookProof_CarlemanUnboundedHop_geoHop_herm
import Theorems.Thm_BookProof_CarlemanUnboundedHop_geoHop_col
open BookProof.CarlemanUnboundedHop




open Finset

noncomputable section

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (b : ℕ → ℝ) {rho : ℝ} (hrho : 0 ≤ rho) (hrho1 : rho < 1) :
    IsL2Kernel (geoHop b rho) := ⟨geoHop_herm b rho, fun k => geoHop_col hrho hrho1 k⟩
