-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.sBd_subset_simplexF
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Theorems.Thm_BookProof_CarlemanSimplex_mem_simplexF
import Theorems.Thm_BookProof_CarlemanSimplex_mem_sBd
open BookProof.CarlemanSimplex











open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (d N k : ℕ) : sBd d N k ⊆ simplexF d N := by

  intro a ha
  rw [mem_sBd] at ha
  exact mem_simplexF.mpr ha.1
