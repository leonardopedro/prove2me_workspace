-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.mem_sInn
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Theorems.Thm_BookProof_CarlemanSimplex_mem_simplexF




open Finset

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {d N k : ℕ} {a : Fin d →₀ ℕ} : a ∈ sInn d N k ↔ deg a + k ≤ N := by

  classical
  rw [sInn, Finset.mem_filter, mem_simplexF]
  exact ⟨fun h => h.2, fun h => ⟨by omega, h⟩⟩
