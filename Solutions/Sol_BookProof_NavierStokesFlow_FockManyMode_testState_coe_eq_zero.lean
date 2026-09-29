-- Generated from ChapterNavierStokesFockManyMode.lean — solution of BookProof.NavierStokesFlow.FockManyMode.testState_coe_eq_zero
import Mathlib
import Definitions.Def_ChapterNavierStokesFockManyMode
import Theorems.Thm_BookProof_NavierStokesFlow_FockManyMode_testState_coe
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode



open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian


variable {d : ℕ} {κ : Fin d → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (i₀ : Fin d) {β : Occ d}
    (h0 : β ≠ 0) (h1 : β ≠ modeShift i₀ 0) :
    ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) β = 0 := by

  rw [testState_coe, if_neg h0, if_neg h1]
