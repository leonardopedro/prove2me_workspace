-- Generated from ChapterNavierStokesShiftHamiltonian.lean — theorem BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.shiftH_relative_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData

variable {ι : Type*} (S : ShiftData ι)


open scoped ENNReal



open LpNat FarisLavine IkebeKato

theorem BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.shiftH_relative_bound (x : maxDom S.sym) :
    ‖(shiftH S x : L2I ι)‖ ^ 2
      ≤ (1 / 2) * ‖(diagMax S.sym x : L2I ι)‖ ^ 2 + (8 * S.K ^ 2) * ‖(x : L2I ι)‖ ^ 2 := by sorry
