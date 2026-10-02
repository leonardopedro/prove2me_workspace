-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.deg_add
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex




open Finset

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a b : Fin d →₀ ℕ) : deg (a + b) = deg a + deg b := by

  simp [deg, Finsupp.add_apply, Finset.sum_add_distrib]
