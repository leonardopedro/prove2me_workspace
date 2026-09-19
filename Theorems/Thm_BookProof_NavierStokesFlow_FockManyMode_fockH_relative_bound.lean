-- Generated from ChapterNavierStokesFockManyMode.lean — theorem BookProof.NavierStokesFlow.FockManyMode.fockH_relative_bound
import Mathlib
import Definitions.Def_Chapter
import Definitions.Def_ChapterNavierStokesIkebeKatoNavierStokesFockManyMode
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode


open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian


variable {d : ℕ} {κ : Fin d → ℝ}

theorem BookProof.NavierStokesFlow.FockManyMode.fockH_relative_bound (hκ : ∀ i, 0 ≤ κ i) (x : maxDom (fockSym κ)) :
    ‖(fockH hκ x : L2I (Occ d))‖ ^ 2
      ≤ ((d : ℝ) ^ 2 / 2) * ‖(diagMax (fockSym κ) x : L2I (Occ d))‖ ^ 2
        + (2 * d * ∑ i, κ i ^ 2) * ‖(x : L2I (Occ d))‖ ^ 2 := by sorry
