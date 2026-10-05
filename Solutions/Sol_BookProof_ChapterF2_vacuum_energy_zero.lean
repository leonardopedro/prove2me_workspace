-- Generated from ChapterF2.lean — solution of BookProof.ChapterF2.vacuum_energy_zero
import Mathlib
import Definitions.Def_ChapterF2
import Theorems.Thm_BookProof_ChapterF1_quadratic_ordering_vacuum
open BookProof.ChapterF2



open Polynomial Finset
open scoped BigOperators


open BookProof.ChapterF1

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : bargmann (1 : ℂ[X]) (hamiltonian (1 : ℂ[X])) = 0 := by

  rw [show hamiltonian (1 : ℂ[X]) = 0 from quadratic_ordering_vacuum]; simp [bargmann]
