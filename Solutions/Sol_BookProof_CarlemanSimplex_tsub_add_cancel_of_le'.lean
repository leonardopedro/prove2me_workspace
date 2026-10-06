-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.tsub_add_cancel_of_le'
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex




open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {P a : Fin d →₀ ℕ} (h : P ≤ a) : a - P + P = a := by

  ext j
  have hj : P j ≤ a j := by
    have := h
    rw [Finsupp.le_def] at this
    exact this j
  simp only [Finsupp.add_apply, Finsupp.tsub_apply]
  omega
