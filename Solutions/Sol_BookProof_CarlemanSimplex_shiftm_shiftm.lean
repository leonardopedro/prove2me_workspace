-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.shiftm_shiftm
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Theorems.Thm_BookProof_CarlemanSimplex_tsub_add_cancel_of_le_prime
open BookProof.CarlemanSimplex




open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution {a : Fin d →₀ ℕ} {i j : Fin d} (h : 1 ≤ a j) :
    shiftm (shiftm a i j) j i = a := by

  have hle : Finsupp.single j 1 ≤ a := by
    rw [Finsupp.le_def]
    intro k
    by_cases hk : k = j
    · subst hk; simpa using h
    · simp [Ne.symm hk]
  rw [shiftm, shiftm, add_tsub_cancel_right, tsub_add_cancel_of_le' hle]
