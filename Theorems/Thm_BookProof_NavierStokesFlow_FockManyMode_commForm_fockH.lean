-- Generated from ChapterNavierStokesFockManyMode.lean — theorem BookProof.NavierStokesFlow.FockManyMode.commForm_fockH
import Mathlib
import Definitions.Def_ChapterNavierStokesFockManyMode
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode










open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.ShiftHamiltonian


variable {d : ℕ} {κ : Fin d → ℝ}

theorem BookProof.NavierStokesFlow.FockManyMode.commForm_fockH (hκ : ∀ i, 0 ≤ κ i) (x : maxDom (fockSym κ)) :
    commForm (fockH hκ) (diagMax (fockSym κ)) x
      = ∑ i, commForm (ShiftData.shiftH (modeData hκ i)) (diagMax (fockSym κ)) x := by sorry
