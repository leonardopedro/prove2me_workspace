-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.rcm_of_zero
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex











open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

















variable {u : (Fin d →₀ ℕ) → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution {a : Fin d →₀ ℕ} {i j : Fin d} (h : a j = 0) : rcm a i j = 0 := by

  rw [rcm, h]
  simp
