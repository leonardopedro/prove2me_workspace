-- Generated from ChapterNavierStokesShiftHamiltonian.lean — solution of BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.abs_le_of_hasSum
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData



open scoped ENNReal



open LpNat FarisLavine IkebeKato

variable {ι : Type*} (S : ShiftData ι)

set_option maxHeartbeats 1000000 in
theorem solution {f g : ι → ℝ} {A B : ℝ} (hf : HasSum f A) (hg : HasSum g B)
    (h : ∀ β, |f β| ≤ g β) : |A| ≤ B := by

  refine abs_le.mpr ⟨?_, hasSum_le (fun β => le_trans (le_abs_self _) (h β)) hf hg⟩
  have hneg : HasSum (fun β => -g β) (-B) := hg.neg
  have := hasSum_le (fun β => by linarith [neg_abs_le (f β), h β] : ∀ β, -g β ≤ f β) hneg hf
  linarith
