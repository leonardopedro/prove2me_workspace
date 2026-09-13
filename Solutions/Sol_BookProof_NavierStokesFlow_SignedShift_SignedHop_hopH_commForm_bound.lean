-- Generated from ChapterNavierStokesSignedShift.lean — solution of BookProof.NavierStokesFlow.SignedShift.SignedHop.hopH_commForm_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesSignedShift
import Theorems.Thm_BookProof_NavierStokesFlow_SignedShift_SignedHop_hasSum_commForm
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
    |commForm (hopH S) (diagMax sym) x|
      ≤ (2 * S.step * (1 / 4 + S.K)) * quadForm (diagMax sym) x := by

  have hus := ShiftData.summable_ampOcc S.maj x
  have hutail : Summable (fun β => S.maj.amp (S.maj.shift β)
      * ‖((x : L2I ι) : ι → ℂ) (S.maj.shift β)‖ ^ 2) :=
    ShiftData.summable_comp_shift S.maj hus
  have hbound : HasSum (fun β => S.step * (S.bnd β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2
      + S.bnd (S.shift β) * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2))
      (S.step * ((∑' β, S.maj.amp β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2)
        + ∑' β, S.maj.amp (S.maj.shift β)
          * ‖((x : L2I ι) : ι → ℂ) (S.maj.shift β)‖ ^ 2)) :=
    (hus.hasSum.add hutail.hasSum).mul_left S.step
  have hptle : ∀ β, |2 * S.step * (S.amp β * ((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
        * ((x : L2I ι) : ι → ℂ) (S.shift β)).re)|
      ≤ S.step * (S.bnd β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2
        + S.bnd (S.shift β) * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2) := by
    intro β
    have hstep : 0 ≤ S.step := S.step_nonneg
    have habs : 0 ≤ |S.amp β| := abs_nonneg _
    have hre : |((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
        * ((x : L2I ι) : ι → ℂ) (S.shift β)).re|
        ≤ ‖((x : L2I ι) : ι → ℂ) β‖ * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ := by
      refine le_trans (Complex.abs_re_le_norm _) ?_
      rw [norm_mul, RCLike.norm_conj]
    set R := ((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
      * ((x : L2I ι) : ι → ℂ) (S.shift β)).re with hR
    set u := ‖((x : L2I ι) : ι → ℂ) β‖ with hu
    set v := ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ with hv
    have hu0 : 0 ≤ u := norm_nonneg _
    have hv0 : 0 ≤ v := norm_nonneg _
    have hrw : |2 * S.step * (S.amp β * R)| = 2 * S.step * (|S.amp β| * |R|) := by
      rw [show (2 : ℝ) * S.step * (S.amp β * R) = (2 * S.step) * (S.amp β * R) from by ring,
        abs_mul, abs_of_nonneg (by positivity : (0 : ℝ) ≤ 2 * S.step), abs_mul]
    have hA : 2 * S.step * (|S.amp β| * |R|) ≤ 2 * S.step * (|S.amp β| * (u * v)) :=
      mul_le_mul_of_nonneg_left (mul_le_mul_of_nonneg_left hre habs) (by positivity)
    have h2ab : 2 * (u * v) ≤ u ^ 2 + v ^ 2 := by nlinarith [sq_nonneg (u - v)]
    have hB : 2 * S.step * (|S.amp β| * (u * v))
        ≤ S.step * (|S.amp β| * u ^ 2 + |S.amp β| * v ^ 2) := by
      nlinarith [mul_le_mul_of_nonneg_left h2ab
        (show (0 : ℝ) ≤ S.step * |S.amp β| by positivity)]
    have hb1 : |S.amp β| * u ^ 2 ≤ S.bnd β * u ^ 2 :=
      mul_le_mul_of_nonneg_right (S.abs_amp_le_bnd β) (sq_nonneg _)
    have hb2 : |S.amp β| * v ^ 2 ≤ S.bnd (S.shift β) * v ^ 2 :=
      mul_le_mul_of_nonneg_right (le_trans (S.abs_amp_le_bnd β) (S.bnd_mono β)) (sq_nonneg _)
    have hC : S.step * (|S.amp β| * u ^ 2 + |S.amp β| * v ^ 2)
        ≤ S.step * (S.bnd β * u ^ 2 + S.bnd (S.shift β) * v ^ 2) :=
      mul_le_mul_of_nonneg_left (add_le_add hb1 hb2) hstep
    rw [hrw]
    linarith [hA, hB, hC]
  have habs := ShiftData.abs_le_of_hasSum (hasSum_commForm S x) hbound hptle
  have htail : (∑' β, S.maj.amp (S.maj.shift β)
        * ‖((x : L2I ι) : ι → ℂ) (S.maj.shift β)‖ ^ 2)
      ≤ ∑' β, S.maj.amp β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2 :=
    tsum_comp_le_tsum_of_inj hus
      (fun β => mul_nonneg (S.maj.amp_nonneg β) (sq_nonneg _)) S.maj.shift_injective
  have hU := ShiftData.tsum_ampOcc_le S.maj x
  have hdiag : quadForm (diagMax S.maj.sym) x = quadForm (diagMax sym) x := rfl
  rw [hdiag] at hU
  have hK : S.maj.K = S.K := rfl
  rw [hK] at hU
  have hqf : 0 ≤ quadForm (diagMax sym) x :=
    diagMax_quadForm_nonneg _ (fun β => le_trans zero_le_one (S.sym_ge_one β)) x
  refine le_trans habs ?_
  nlinarith [hU, htail, S.step_nonneg, S.K_nonneg]
