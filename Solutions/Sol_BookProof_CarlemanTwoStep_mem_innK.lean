-- Generated from ChapterCarlemanTwoStep.lean — solution of BookProof.CarlemanTwoStep.mem_innK
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep











open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {d N : ℕ} {i : Fin d} {k : ℕ} {a : Fin d →₀ ℕ} :
    a ∈ innK d N i k ↔ (∀ j, a j ≤ N) ∧ a i + k ≤ N := by

  classical
  rw [innK, Finset.mem_filter, mem_cube]
