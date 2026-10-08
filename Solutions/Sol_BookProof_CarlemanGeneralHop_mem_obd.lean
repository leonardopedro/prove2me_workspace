-- Generated from ChapterCarlemanGeneralHop.lean — solution of BookProof.CarlemanGeneralHop.mem_obd
import Mathlib
import Definitions.Def_ChapterCarlemanGeneralHop
import Theorems.Thm_BookProof_HermiteCarleman_mem_cube
open BookProof.CarlemanGeneralHop




open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} {p m a : Fin d →₀ ℕ} :
    a ∈ obd d N p m ↔ (∀ k, a k ≤ N) ∧ (∀ k, m k ≤ a k) ∧ ∃ k, N < a k + p k := by

  classical
  rw [obd, Finset.mem_filter, mem_cube]
