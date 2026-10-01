-- Generated from ChapterNavierStokesShiftHamiltonian.lean — solution of BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.mul_hop
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData



open scoped ENNReal



open LpNat FarisLavine IkebeKato

set_option maxHeartbeats 1000000 in
theorem solution (g : ι → ℂ) (Y : ι → ℂ) (β : ι) :
    Y β * S.hop g β = S.hop (fun α => Y (S.shift α) * g α) β := by

  by_cases hb : ∃ α, S.shift α = β
  · obtain ⟨α, rfl⟩ := hb
    rw [hop_shift, hop_shift]
  · rw [hop_eq_zero S g hb, hop_eq_zero S _ hb, mul_zero]
