-- Generated from ChapterNavierStokesFockManyMode.lean — theorem BookProof.NavierStokesFlow.FockManyMode.fockH_commForm_bound
import Mathlib
import Definitions.Def_Chapter
import Definitions.Def_ChapterNavierStokesIkebeKatoNavierStokesFockManyMode
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode


open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian


variable {d : ℕ} {κ : Fin d → ℝ}

theorem BookProof.NavierStokesFlow.FockManyMode.fockH_commForm_bound (hκ : ∀ i, 0 ≤ κ i) (x : maxDom (fockSym κ)) :
    |commForm (fockH hκ) (diagMax (fockSym κ)) x|
      ≤ (∑ i, (2 * κ i + 4 * κ i ^ 2)) * quadForm (diagMax (fockSym κ)) x := by sorry
