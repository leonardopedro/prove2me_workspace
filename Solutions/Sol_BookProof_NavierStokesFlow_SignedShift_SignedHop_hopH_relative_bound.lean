-- Generated from ChapterNavierStokesSignedShift.lean — solution of BookProof.NavierStokesFlow.SignedShift.SignedHop.hopH_relative_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesSignedShift
import Theorems.Thm_BookProof_NavierStokesFlow_SignedShift_SignedHop_hopH_coe
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignedShift
open BookProof.NavierStokesFlow.SignedShift.SignedHop










open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.ShiftHamiltonian BookProof.NavierStokesFlow.AffineFiber

variable {ι : Type*}



variable {sym : ι → ℝ} (S : SignedHop ι sym)

set_option maxHeartbeats 1000000 in
theorem solution (x : maxDom sym) :
    ‖(hopH S x : L2I ι)‖ ^ 2
      ≤ (1 / 2) * ‖(diagMax sym x : L2I ι)‖ ^ 2 + (8 * S.K ^ 2) * ‖(x : L2I ι)‖ ^ 2 := by

  have hS := ShiftData.summable_ampSeq_sq S.maj x
  have hshift : Summable (S.maj.hop fun β => (S.maj.ampSeq ((x : L2I ι) : ι → ℂ) β) ^ 2) :=
    ShiftData.summable_hop S.maj hS
  have htail : Summable (fun β => (S.maj.ampSeq ((x : L2I ι) : ι → ℂ) (S.maj.shift β)) ^ 2) :=
    ShiftData.summable_comp_shift S.maj hS
  have hbound := (hshift.hasSum.mul_left 2).add (htail.hasSum.mul_left 2)
  have hle : ‖(hopH S x : L2I ι)‖ ^ 2
      ≤ 2 * (∑' β, S.maj.hop (fun α => (S.maj.ampSeq ((x : L2I ι) : ι → ℂ) α) ^ 2) β)
        + 2 * ∑' β, (S.maj.ampSeq ((x : L2I ι) : ι → ℂ) (S.maj.shift β)) ^ 2 := by
    refine hasSum_le (fun β => ?_) (ShiftData.hasSum_normSq (hopH S x : L2I ι)) hbound
    rw [hopH_coe]
    exact normSq_hFun_le S _ β
  have hshifteq : (∑' β, S.maj.hop (fun α => (S.maj.ampSeq ((x : L2I ι) : ι → ℂ) α) ^ 2) β)
      = ∑' β, (S.maj.ampSeq ((x : L2I ι) : ι → ℂ) β) ^ 2 :=
    ((ShiftData.hasSum_hop_iff S.maj).mpr hS.hasSum).tsum_eq
  have htaille : (∑' β, (S.maj.ampSeq ((x : L2I ι) : ι → ℂ) (S.maj.shift β)) ^ 2)
      ≤ ∑' β, (S.maj.ampSeq ((x : L2I ι) : ι → ℂ) β) ^ 2 :=
    tsum_comp_le_tsum_of_inj hS (fun _ => sq_nonneg _) S.maj.shift_injective
  have hT := ShiftData.tsum_ampSeq_sq_le S.maj x
  rw [hshifteq] at hle
  have hdiag : (diagMax S.maj.sym x : L2I ι) = (diagMax sym x : L2I ι) := rfl
  rw [hdiag] at hT
  have hK : S.maj.K = S.K := rfl
  rw [hK] at hT
  linarith
