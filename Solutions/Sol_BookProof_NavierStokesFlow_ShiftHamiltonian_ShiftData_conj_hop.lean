-- Generated from ChapterNavierStokesShiftHamiltonian.lean — solution of BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.conj_hop
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*} (S : ShiftData ι)

set_option maxHeartbeats 1000000 in
theorem solution (g : ι → ℂ) (β : ι) :
    (starRingEnd ℂ) (S.hop g β) = S.hop (fun α => (starRingEnd ℂ) (g α)) β := by

  by_cases hb : ∃ α, S.shift α = β
  · obtain ⟨α, rfl⟩ := hb
    rw [hop_shift, hop_shift]
  · rw [hop_eq_zero S g hb, hop_eq_zero S _ hb, map_zero]
