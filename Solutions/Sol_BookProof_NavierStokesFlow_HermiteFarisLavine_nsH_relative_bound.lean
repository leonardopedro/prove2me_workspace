-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — solution of BookProof.NavierStokesFlow.HermiteFarisLavine.nsH_relative_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_tsum_ampSeq_sq_le
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_nsH_coe
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_normSq_hFun_le
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_tsum_shift_le
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine



open scoped ENNReal



open LpNat FarisLavine IkebeKato

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}

set_option maxHeartbeats 1000000 in
theorem solution (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) :
    ‖(nsH κ hκ x : L2I ℕ)‖ ^ 2
      ≤ (1 / 2) * ‖(diagMax (oscSymbol κ) x : L2I ℕ)‖ ^ 2 + (2 * κ ^ 2) * ‖(x : L2I ℕ)‖ ^ 2 := by

  have hS := summable_ampSeq_sq hκ x
  have hshift : Summable (shift2 (fun n => (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) n) ^ 2)) :=
    summable_shift2 hS
  have htail : Summable (fun m => (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) (m + 2)) ^ 2) :=
    (summable_nat_add_iff 2).mpr hS
  have hbound := (hshift.hasSum.mul_left 2).add (htail.hasSum.mul_left 2)
  have hle : ‖(nsH κ hκ x : L2I ℕ)‖ ^ 2
      ≤ 2 * (∑' m, shift2 (fun n => (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) n) ^ 2) m)
        + 2 * ∑' m, (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) (m + 2)) ^ 2 := by
    refine hasSum_le (fun m => ?_) (hasSum_normSq (nsH κ hκ x : L2I ℕ)) hbound
    rw [nsH_coe]
    exact normSq_hFun_le hκ _ m
  have hshifteq : (∑' m, shift2 (fun n => (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) n) ^ 2) m)
      = ∑' n, (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) n) ^ 2 :=
    (hasSum_shift2_iff.mpr hS.hasSum).tsum_eq
  have htaille : (∑' m, (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) (m + 2)) ^ 2)
      ≤ ∑' n, (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) n) ^ 2 :=
    tsum_shift_le hS (fun n => sq_nonneg _)
  have hT := tsum_ampSeq_sq_le hκ x
  rw [hshifteq] at hle
  linarith
