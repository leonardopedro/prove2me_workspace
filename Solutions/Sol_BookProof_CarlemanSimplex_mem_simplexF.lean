-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.mem_simplexF
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Theorems.Thm_BookProof_CarlemanSimplex_apply_le_deg




open Finset

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {d N : ℕ} {a : Fin d →₀ ℕ} : a ∈ simplexF d N ↔ deg a ≤ N := by

  classical
  rw [simplexF, Finset.mem_filter, mem_cube]
  exact ⟨fun h => h.2, fun h => ⟨fun i => le_trans (apply_le_deg a i) h, h⟩⟩
