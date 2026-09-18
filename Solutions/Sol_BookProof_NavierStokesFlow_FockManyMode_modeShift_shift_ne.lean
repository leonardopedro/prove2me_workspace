-- Generated from ChapterNavierStokesFockManyMode.lean — solution of BookProof.NavierStokesFlow.FockManyMode.modeShift_shift_ne
import Mathlib
import Definitions.Def_ChapterNavierStokesFockManyMode
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode



open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian


variable {d : ℕ} {κ : Fin d → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (i i₀ : Fin d) :
    modeShift i (modeShift i₀ (0 : Occ d)) ≠ 0 := by

  intro h
  have hi := congrFun h i
  rw [modeShift_self] at hi
  simp at hi
