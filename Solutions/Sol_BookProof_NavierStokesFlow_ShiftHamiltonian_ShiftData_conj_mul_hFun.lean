-- Generated from ChapterNavierStokesShiftHamiltonian.lean — solution of BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.conj_mul_hFun
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*} (S : ShiftData ι)

set_option maxHeartbeats 1000000 in
theorem solution (X Y : ι → ℂ) (β : ι) :
    (starRingEnd ℂ) (X β) * S.hFun Y β
      = -Complex.I * S.crossA X Y β + Complex.I * S.hop (S.crossB X Y) β := by

  have h2 : (starRingEnd ℂ) (X β) * S.hop (fun α => (S.amp α : ℂ) * Y α) β
      = S.hop (S.crossB X Y) β := by
    by_cases hb : ∃ α, S.shift α = β
    · obtain ⟨α, rfl⟩ := hb
      rw [hop_shift, hop_shift]
      simp only [crossB]
      ring
    · rw [hop_eq_zero S _ hb, hop_eq_zero S _ hb, mul_zero]
  have hexp : (starRingEnd ℂ) (X β) * S.hFun Y β
      = Complex.I * ((starRingEnd ℂ) (X β) * S.hop (fun α => (S.amp α : ℂ) * Y α) β)
        - Complex.I * ((S.amp β : ℂ) * (starRingEnd ℂ) (X β) * Y (S.shift β)) := by
    simp only [hFun]
    ring
  rw [hexp, h2]
  simp only [crossA]
  ring
