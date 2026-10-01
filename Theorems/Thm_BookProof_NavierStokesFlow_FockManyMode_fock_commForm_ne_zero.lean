-- Generated from ChapterNavierStokesFockManyMode.lean — theorem BookProof.NavierStokesFlow.FockManyMode.fock_commForm_ne_zero
import Mathlib
import Definitions.Def_ChapterNavierStokesFockManyMode
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode

variable {d : ℕ} {κ : Fin d → ℝ}


open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian


variable {d : ℕ} {κ : Fin d → ℝ}

, hstep, hc0, hc1]
  simp

theorem BookProof.NavierStokesFlow.FockManyMode.fock_commForm_ne_zero (hκ : ∀ i, 0 ≤ κ i) (i₀ : Fin d) (hpos : 0 < κ i₀) :
    commForm (fockH hκ) (diagMax (fockSym κ)) := by sorry
