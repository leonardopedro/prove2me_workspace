-- Generated from ChapterCarlemanGeneralHop.lean — solution of BookProof.CarlemanGeneralHop.mem_ibd
import Mathlib
import Definitions.Def_ChapterCarlemanGeneralHop
open BookProof.CarlemanGeneralHop




open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} {m b : Fin d →₀ ℕ} :
    b ∈ ibd d N m ↔ (∀ k, b k ≤ N + 1) ∧ (∀ k, m k ≤ b k) ∧ ¬ (∀ k, b k ≤ N) := by

  classical
  rw [ibd, Finset.mem_filter, mem_cube]
