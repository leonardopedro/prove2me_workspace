-- Generated from ChapterNavierStokesShiftHamiltonian.lean — solution of BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.shiftH_commForm_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_hasSum_commForm
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_summable_ampOcc
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_tsum_ampOcc_le
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_abs_le_of_hasSum
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_quadForm_nonneg
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData



open scoped ENNReal



open LpNat FarisLavine IkebeKato

set_option maxHeartbeats 1000000 in
theorem solution (x : maxDom S.sym) :
    |commForm (shiftH S) (diagMax S.sym) x|
      ≤ (2 * S.step * (1 / 4 + S.K)) * quadForm (diagMax S.sym) x := by

  have hus := summable_ampOcc S x
  have hutail : Summable (fun β => S.amp (S.shift β)
      * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2) :=
    summable_comp_shift S hus
  have hbound : HasSum (fun β => S.step * (S.amp β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2
      + S.amp (S.shift β) * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2))
      (S.step * ((∑' β, S.amp β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2)
        + ∑' β, S.amp (S.shift β) * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2)) :=
    (hus.hasSum.add hutail.hasSum).mul_left S.step
  have hptle : ∀ β, |2 * S.step * (S.amp β * ((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
        * ((x : L2I ι) : ι → ℂ) (S.shift β)).re)|
      ≤ S.step * (S.amp β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2
        + S.amp (S.shift β) * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2) := by
    intro β
    have hamp : 0 ≤ S.amp β := S.amp_nonneg β
    have hstep : 0 ≤ S.step := S.step_nonneg
    have hre : |((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
        * ((x : L2I ι) : ι → ℂ) (S.shift β)).re|
        ≤ ‖((x : L2I ι) : ι → ℂ) β‖ * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ := by
      refine le_trans (Complex.abs_re_le_norm _) ?_
      rw [norm_mul, RCLike.norm_conj]
    have habs : |2 * S.step * (S.amp β * ((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
          * ((x : L2I ι) : ι → ℂ) (S.shift β)).re)|
        = 2 * S.step * S.amp β * |((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
          * ((x : L2I ι) : ι → ℂ) (S.shift β)).re| := by
      rw [show (2 : ℝ) * S.step * (S.amp β * ((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
          * ((x : L2I ι) : ι → ℂ) (S.shift β)).re)
          = (2 * S.step * S.amp β) * ((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
            * ((x : L2I ι) : ι → ℂ) (S.shift β)).re from by ring, abs_mul,
        abs_of_nonneg (by positivity : (0 : ℝ) ≤ 2 * S.step * S.amp β)]
    have h1 : 2 * S.step * S.amp β * |((starRingEnd ℂ) (((x : L2I ι) : ι → ℂ) β)
          * ((x : L2I ι) : ι → ℂ) (S.shift β)).re|
        ≤ 2 * S.step * S.amp β * (‖((x : L2I ι) : ι → ℂ) β‖
          * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖) :=
      mul_le_mul_of_nonneg_left hre (by positivity)
    have hkey : 2 * S.step * S.amp β * (‖((x : L2I ι) : ι → ℂ) β‖
          * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖)
        ≤ S.step * (S.amp β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2
          + S.amp β * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2) := by
      have h2ab : 2 * (‖((x : L2I ι) : ι → ℂ) β‖ * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖)
          ≤ ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2 + ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2 := by
        nlinarith [sq_nonneg (‖((x : L2I ι) : ι → ℂ) β‖
          - ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖)]
      have := mul_le_mul_of_nonneg_left h2ab
        (show (0 : ℝ) ≤ S.step * S.amp β by positivity)
      linarith [this]
    have hmono : S.step * (S.amp β * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2)
        ≤ S.step * (S.amp (S.shift β) * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2) :=
      mul_le_mul_of_nonneg_left
        (mul_le_mul_of_nonneg_right (S.amp_mono β) (sq_nonneg _)) hstep
    rw [habs]
    linarith
  have habs := abs_le_of_hasSum (hasSum_commForm S x) hbound hptle
  have htail : (∑' β, S.amp (S.shift β) * ‖((x : L2I ι) : ι → ℂ) (S.shift β)‖ ^ 2)
      ≤ ∑' β, S.amp β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2 :=
    tsum_comp_le_tsum_of_inj hus
      (fun β => mul_nonneg (S.amp_nonneg β) (sq_nonneg _)) S.shift_injective
  have hU := tsum_ampOcc_le S x
  have hqf : 0 ≤ quadForm (diagMax S.sym) x :=
    diagMax_quadForm_nonneg _ (sym_nonneg S) x
  refine le_trans habs ?_
  nlinarith [hU, htail, S.step_nonneg, S.K_nonneg]
