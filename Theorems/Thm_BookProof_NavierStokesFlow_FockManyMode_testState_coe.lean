-- Generated from ChapterNavierStokesFockManyMode.lean — theorem BookProof.NavierStokesFlow.FockManyMode.testState_coe
import Mathlib
import Definitions.Def_Chapter
import Definitions.Def_ChapterNavierStokesIkebeKatoNavierStokesFockManyMode
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode


open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian


variable {d : ℕ} {κ : Fin d → ℝ}

theorem BookProof.NavierStokesFlow.FockManyMode.testState_coe (i₀ : Fin d) (β : Occ d) :
    ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) β
      = if β = 0 then 1 else if β = modeShift i₀ 0 then 1 else 0 := by sorry
