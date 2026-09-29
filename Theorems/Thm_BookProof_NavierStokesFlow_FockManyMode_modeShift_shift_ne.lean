-- Generated from ChapterNavierStokesFockManyMode.lean — theorem BookProof.NavierStokesFlow.FockManyMode.modeShift_shift_ne
import Mathlib
import Definitions.Def_ChapterNavierStokesFockManyMode
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode










open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.ShiftHamiltonian


variable {d : ℕ} {κ : Fin d → ℝ}

theorem BookProof.NavierStokesFlow.FockManyMode.modeShift_shift_ne (i i₀ : Fin d) :
    modeShift i (modeShift i₀ (0 : Occ d)) ≠ 0 := by sorry
