-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.mem_sBd
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Theorems.Thm_BookProof_CarlemanSimplex_mem_simplexF
open BookProof.CarlemanSimplex











open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {d N k : ℕ} {a : Fin d →₀ ℕ} :
    a ∈ sBd d N k ↔ deg a ≤ N ∧ N < deg a + k := by

  classical
  rw [sBd, Finset.mem_filter, mem_simplexF]
