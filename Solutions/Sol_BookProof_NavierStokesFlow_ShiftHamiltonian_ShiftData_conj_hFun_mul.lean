-- Generated from ChapterNavierStokesShiftHamiltonian.lean — solution of BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.conj_hFun_mul
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_hop_mul
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_conj_hop
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData



open scoped ENNReal



open LpNat FarisLavine IkebeKato

set_option maxHeartbeats 1000000 in
theorem solution (X Y : ι → ℂ) (β : ι) :
    (starRingEnd ℂ) (S.hFun X β) * Y β
      = -Complex.I * S.hop (S.crossA X Y) β + Complex.I * S.crossB X Y β := by

  have h1 : (starRingEnd ℂ) (S.hop (fun α => (S.amp α : ℂ) * X α) β)
      = S.hop (fun α => (S.amp α : ℂ) * (starRingEnd ℂ) (X α)) β := by
    rw [conj_hop]
    congr 1
    funext α
    simp
  have h2 : S.hop (fun α => (S.amp α : ℂ) * (starRingEnd ℂ) (X α)) β * Y β
      = S.hop (S.crossA X Y) β := by
    rw [hop_mul]
    rfl
  have hexp : (starRingEnd ℂ) (S.hFun X β) * Y β
      = -Complex.I * ((starRingEnd ℂ) (S.hop (fun α => (S.amp α : ℂ) * X α) β) * Y β)
        + Complex.I * ((S.amp β : ℂ) * (starRingEnd ℂ) (X (S.shift β)) * Y β) := by
    simp only [hFun, map_mul, map_sub, Complex.conj_I, Complex.conj_ofReal]
    ring
  rw [hexp, h1, h2]
  rfl
