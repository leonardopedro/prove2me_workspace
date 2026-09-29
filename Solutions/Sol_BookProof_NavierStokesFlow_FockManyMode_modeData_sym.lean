-- Generated from ChapterNavierStokesFockManyMode.lean — solution of BookProof.NavierStokesFlow.FockManyMode.modeData_sym
import Mathlib
import Definitions.Def_ChapterNavierStokesFockManyMode
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode











open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.ShiftHamiltonian


variable {d : ℕ} {κ : Fin d → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hκ : ∀ i, 0 ≤ κ i) (i : Fin d) :
    (modeData hκ i).sym = fockSym κ := rfl
