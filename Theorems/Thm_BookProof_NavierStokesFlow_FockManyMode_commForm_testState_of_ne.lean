-- Generated from ChapterNavierStokesFockManyMode.lean — theorem BookProof.NavierStokesFlow.FockManyMode.commForm_testState_of_ne
import Mathlib
import Definitions.Def_Chapter
import Definitions.Def_ChapterNavierStokesIkebeKatoNavierStokesFockManyMode
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode


open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian


variable {d : ℕ} {κ : Fin d → ℝ}

theorem BookProof.NavierStokesFlow.FockManyMode.commForm_testState_of_ne (hκ : ∀ i, 0 ≤ κ i) {i i₀ : Fin d} (hne : i ≠ i₀) :
    commForm (ShiftData.shiftH (modeData hκ i)) (diagMax (fockSym κ)) (testState κ i₀) = 0 := by sorry
