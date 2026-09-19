-- Generated from ChapterNavierStokesFockManyMode.lean — theorem BookProof.NavierStokesFlow.FockManyMode.testState_coe_eq_zero
import Mathlib
import Definitions.Def_Chapter
import Definitions.Def_ChapterNavierStokesIkebeKatoNavierStokesFockManyMode
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode


open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian


variable {d : ℕ} {κ : Fin d → ℝ}

theorem BookProof.NavierStokesFlow.FockManyMode.testState_coe_eq_zero (i₀ : Fin d) {β : Occ d}
    (h0 : β ≠ 0) (h1 : β ≠ modeShift i₀ 0) :
    ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) β = 0 := by sorry
