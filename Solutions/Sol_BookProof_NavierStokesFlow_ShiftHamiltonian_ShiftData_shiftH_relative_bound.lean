-- Generated from ChapterNavierStokesShiftHamiltonian.lean — solution of BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.shiftH_relative_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_tsum_ampSeq_sq_le
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_shiftH_coe
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_normSq_hFun_le
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData



open scoped ENNReal



open LpNat FarisLavine IkebeKato

set_option maxHeartbeats 1000000 in
theorem solution (x : maxDom S.sym) :
    ‖(shiftH S x : L2I ι)‖ ^ 2
      ≤ (1 / 2) * ‖(diagMax S.sym x : L2I ι)‖ ^ 2 + (8 * S.K ^ 2) * ‖(x : L2I ι)‖ ^ 2 := by

  have hS := summable_ampSeq_sq S x
  have hshift : Summable (S.hop fun β => (S.ampSeq ((x : L2I ι) : ι → ℂ) β) ^ 2) :=
    summable_hop S hS
  have htail : Summable (fun β => (S.ampSeq ((x : L2I ι) : ι → ℂ) (S.shift β)) ^ 2) :=
    summable_comp_shift S hS
  have hbound := (hshift.hasSum.mul_left 2).add (htail.hasSum.mul_left 2)
  have hle : ‖(shiftH S x : L2I ι)‖ ^ 2
      ≤ 2 * (∑' β, S.hop (fun α => (S.ampSeq ((x : L2I ι) : ι → ℂ) α) ^ 2) β)
        + 2 * ∑' β, (S.ampSeq ((x : L2I ι) : ι → ℂ) (S.shift β)) ^ 2 := by
    refine hasSum_le (fun β => ?_) (hasSum_normSq (shiftH S x : L2I ι)) hbound
    rw [shiftH_coe]
    exact normSq_hFun_le S _ β
  have hshifteq : (∑' β, S.hop (fun α => (S.ampSeq ((x : L2I ι) : ι → ℂ) α) ^ 2) β)
      = ∑' β, (S.ampSeq ((x : L2I ι) : ι → ℂ) β) ^ 2 :=
    ((hasSum_hop_iff S).mpr hS.hasSum).tsum_eq
  have htaille : (∑' β, (S.ampSeq ((x : L2I ι) : ι → ℂ) (S.shift β)) ^ 2)
      ≤ ∑' β, (S.ampSeq ((x : L2I ι) : ι → ℂ) β) ^ 2 :=
    tsum_comp_le_tsum_of_inj hS (fun _ => sq_nonneg _) S.shift_injective
  have hT := tsum_ampSeq_sq_le S x
  rw [hshifteq] at hle
  linarith
