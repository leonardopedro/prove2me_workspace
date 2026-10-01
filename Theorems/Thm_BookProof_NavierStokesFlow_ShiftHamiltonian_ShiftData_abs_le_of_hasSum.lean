-- Generated from ChapterNavierStokesShiftHamiltonian.lean — theorem BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.abs_le_of_hasSum
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData

variable {ι : Type*} (S : ShiftData ι)


open scoped ENNReal



open LpNat FarisLavine IkebeKato

theorem BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.abs_le_of_hasSum {f g : ι → ℝ} {A B : ℝ} (hf : HasSum f A) (hg : HasSum g B)
    (h : ∀ β, |f β| ≤ g β) : |A| ≤ B := by sorry
