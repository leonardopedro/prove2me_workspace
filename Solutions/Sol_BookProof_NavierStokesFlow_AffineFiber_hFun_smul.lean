-- Generated from ChapterNavierStokesAffineFiberEsa.lean — solution of BookProof.NavierStokesFlow.AffineFiber.hFun_smul
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber



open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
open ShiftHamiltonian in
theorem solution (S : ShiftData ι) (a : ℂ) (X : ι → ℂ) (β : ι) :
    S.hFun (fun α => a * X α) β = a * S.hFun X β := by

  by_cases hb : ∃ α, S.shift α = β
  · obtain ⟨α, rfl⟩ := hb
    simp only [ShiftData.hFun, ShiftData.hop_shift]
    ring
  · have hz : ∀ g : ι → ℂ, S.hop g β = 0 := fun g => ShiftData.hop_eq_zero S g hb
    simp only [ShiftData.hFun, hz]
    ring
