-- Generated from ChapterNavierStokesFockManyMode.lean — theorem BookProof.NavierStokesFlow.FockManyMode.modeShift_zero_inj
import Mathlib
import Definitions.Def_ChapterNavierStokesFockManyMode
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode










open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.ShiftHamiltonian


variable {d : ℕ} {κ : Fin d → ℝ}

theorem BookProof.NavierStokesFlow.FockManyMode.modeShift_zero_inj {i j : Fin d} (h : modeShift i (0 : Occ d) = modeShift j 0) :
    i = j := by sorry
