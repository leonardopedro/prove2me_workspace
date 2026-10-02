-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.deg_single
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex




open Finset

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (k : ℕ) : deg (Finsupp.single i k) = k := by

  simp [deg]
