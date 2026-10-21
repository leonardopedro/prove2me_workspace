-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.deg_tsub_of_le
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Theorems.Thm_BookProof_CarlemanSimplex_deg_add
import Theorems.Thm_BookProof_CarlemanSimplex_tsub_add_cancel_of_le_prime
open BookProof.CarlemanSimplex




open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {P a : Fin d →₀ ℕ} (h : P ≤ a) : deg (a - P) + deg P = deg a := by

  rw [← deg_add, tsub_add_cancel_of_le' h]
