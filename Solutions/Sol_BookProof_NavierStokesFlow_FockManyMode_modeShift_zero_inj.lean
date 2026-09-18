-- Generated from ChapterNavierStokesFockManyMode.lean — solution of BookProof.NavierStokesFlow.FockManyMode.modeShift_zero_inj
import Mathlib
import Definitions.Def_ChapterNavierStokesFockManyMode
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode



open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian


variable {d : ℕ} {κ : Fin d → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {i j : Fin d} (h : modeShift i (0 : Occ d) = modeShift j 0) :
    i = j := by

  by_contra hne
  have hi := congrFun h i
  rw [modeShift_self] at hi
  rw [modeShift, Function.update_of_ne hne] at hi
  simp at hi
