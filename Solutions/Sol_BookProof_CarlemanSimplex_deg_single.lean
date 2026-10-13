-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.deg_single
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Definitions.Def_ChapterHermiteCarlemanEsa
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanSimplex




open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in

theorem solution (i : Fin d) (k : ℕ) : deg (Finsupp.single i k) = k := by
  simp [deg]
