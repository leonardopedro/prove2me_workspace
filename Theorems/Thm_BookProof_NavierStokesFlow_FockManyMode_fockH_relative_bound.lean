-- Generated from ChapterNavierStokesFockManyMode.lean — theorem BookProof.NavierStokesFlow.FockManyMode.fockH_relative_bound
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterNavierStokesFockManyMode
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.DirectSumEsa
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.ShiftHamiltonian
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode

variable {d : ℕ} {κ : Fin d → ℝ}


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ShiftHamiltonian



theorem BookProof.NavierStokesFlow.FockManyMode.fockH_relative_bound (hκ : ∀ i, 0 ≤ κ i) (x : maxDom (fockSym κ)) :
    ‖(fockH hκ x : L2I (Occ d))‖ ^ 2
      ≤ ((d : ℝ) ^ 2 / 2) * ‖(diagMax (fockSym κ) x : L2I (Occ d))‖ ^ 2
        + (2 * d * ∑ i, κ i ^ 2) * ‖(x : L2I (Occ d))‖ ^ 2 := by sorry
