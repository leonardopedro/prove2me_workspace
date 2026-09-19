-- Generated from ChapterNavierStokesFockManyMode.lean — theorem BookProof.NavierStokesFlow.FockManyMode.fock_commForm_ne_zero
import Mathlib
import Definitions.Def_Chapter
import Definitions.Def_ChapterNavierStokesIkebeKatoNavierStokesFockManyMode
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode


open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian


variable {d : ℕ} {κ : Fin d → ℝ}

theorem BookProof.NavierStokesFlow.FockManyMode.fock_commForm_ne_zero (hκ : ∀ i, 0 ≤ κ i) (i₀ : Fin d) (hpos : 0 < κ i₀) :
    commForm (fockH hκ) (diagMax (fockSym κ)) (testState κ i₀) ≠ 0 := by sorry
