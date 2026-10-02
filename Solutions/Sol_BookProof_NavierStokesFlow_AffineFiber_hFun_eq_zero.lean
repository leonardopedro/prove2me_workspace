-- Generated from ChapterNavierStokesAffineFiberEsa.lean — solution of BookProof.NavierStokesFlow.AffineFiber.hFun_eq_zero
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber



open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian

variable {ι : Type*}

variable {ι : Type*}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
open ShiftHamiltonian in
theorem solution (S : ShiftData ι) {X : ι → ℂ} {β : ι}
    (hpre : ∀ α, S.shift α = β → X α = 0) (hX : X (S.shift β) = 0) : S.hFun X β = 0 := by

  unfold ShiftData.hFun
  have hhop : S.hop (fun α => (S.amp α : ℂ) * X α) β = 0 := by
    by_cases hb : ∃ α, S.shift α = β
    · obtain ⟨α, rfl⟩ := hb
      rw [ShiftData.hop_shift, hpre α rfl, mul_zero]
    · exact ShiftData.hop_eq_zero S _ hb
  rw [hhop, hX, mul_zero, sub_zero, mul_zero]
