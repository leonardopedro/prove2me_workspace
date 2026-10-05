-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.norm_dGamma_le_of_sector
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_dGamma_inSector
import Theorems.Thm_BookProof_FockSchur_sum_normSq_annA_of_sector
import Theorems.Thm_BookProof_FockSchur_sum_norm_col_le
import Theorems.Thm_BookProof_FockSchur_schur_test
import Theorems.Thm_BookProof_FockSecondQuantization_col_support_subset_closure
import Theorems.Thm_BookProof_FockSecondQuantization_inner_dGamma_left
import Theorems.Thm_BookProof_FockSecondQuantization_modes_left_subset_closure
import Theorems.Thm_BookProof_FockSecondQuantization_modes_right_subset_closure
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hK : SchurBound col K) (hherm : IsHermCol col) (hK0 : 0 ≤ K)
    {n : ℕ} {u : FockAlg} (hu : InSector n u) :
    ‖toLp (dGamma col u)‖ ≤ K * n * ‖toLp u‖ := by

  classical
  set v : FockAlg := dGamma col u with hv
  have hvsec : InSector n v := dGamma_inSector col hu
  set L : Finset ℕ := closureModes col u v with hLdef
  have hexp : (inner ℂ (toLp v) (toLp v) : ℂ)
      = ∑ k ∈ L, ∑ j ∈ L, (starRingEnd ℂ) ((col k) j)
          * inner ℂ (toLp (annA k u)) (toLp (annA j v)) :=
    inner_dGamma_left col u v (modes_left_subset_closure col u v)
      (col_support_subset_closure col u v)
  have hbound : ‖toLp v‖ ^ 2 ≤ ∑ k ∈ L, ∑ j ∈ L,
      ‖(col k) j‖ * (‖toLp (annA k u)‖ * ‖toLp (annA j v)‖) := by
    have h0 : ((‖toLp v‖ ^ 2 : ℝ) : ℂ) = ∑ k ∈ L, ∑ j ∈ L, (starRingEnd ℂ) ((col k) j)
        * inner ℂ (toLp (annA k u)) (toLp (annA j v)) := by
      rw [← hexp, inner_self_eq_norm_sq_to_K]
      norm_cast
    have h1 : ‖toLp v‖ ^ 2 = ‖(∑ k ∈ L, ∑ j ∈ L, (starRingEnd ℂ) ((col k) j)
        * inner ℂ (toLp (annA k u)) (toLp (annA j v)) : ℂ)‖ := by
      rw [← h0, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (sq_nonneg _)]
    rw [h1]
    refine le_trans (norm_sum_le _ _) (Finset.sum_le_sum fun k _ => ?_)
    refine le_trans (norm_sum_le _ _) (Finset.sum_le_sum fun j _ => ?_)
    rw [norm_mul, RCLike.norm_conj]
    exact mul_le_mul_of_nonneg_left (norm_inner_le_norm _ _) (norm_nonneg _)
  have hschur := schur_test (L := L) (m := fun k j => ‖(col k) j‖)
    (x := fun k => ‖toLp (annA k u)‖) (y := fun j => ‖toLp (annA j v)‖) (K := K)
    (fun k j => norm_nonneg _) (fun k => norm_nonneg _) (fun j => norm_nonneg _) hK0
    (fun k => sum_norm_col_le hK k L)
    (fun j => by
      have hcongr : ∑ k ∈ L, ‖(col k) j‖ = ∑ k ∈ L, ‖(col j) k‖ := by
        refine Finset.sum_congr rfl fun k _ => ?_
        rw [hherm j k]
        simp
      rw [hcongr]
      exact sum_norm_col_le hK j L)
  have hsu : ∑ k ∈ L, ‖toLp (annA k u)‖ ^ 2 = (n : ℝ) * ‖toLp u‖ ^ 2 :=
    sum_normSq_annA_of_sector hu (modes_left_subset_closure col u v)
  have hsv : ∑ j ∈ L, ‖toLp (annA j v)‖ ^ 2 = (n : ℝ) * ‖toLp v‖ ^ 2 :=
    sum_normSq_annA_of_sector hvsec (modes_right_subset_closure col u v)
  have hsqrtu : Real.sqrt ((n : ℝ) * ‖toLp u‖ ^ 2) = Real.sqrt n * ‖toLp u‖ := by
    rw [Real.sqrt_mul (Nat.cast_nonneg n), Real.sqrt_sq (norm_nonneg _)]
  have hsqrtv : Real.sqrt ((n : ℝ) * ‖toLp v‖ ^ 2) = Real.sqrt n * ‖toLp v‖ := by
    rw [Real.sqrt_mul (Nat.cast_nonneg n), Real.sqrt_sq (norm_nonneg _)]
  rw [hsu, hsv, hsqrtu, hsqrtv] at hschur
  have hnn : Real.sqrt n * Real.sqrt n = (n : ℝ) := Real.mul_self_sqrt (Nat.cast_nonneg n)
  have hkey : ‖toLp v‖ ^ 2 ≤ K * (n : ℝ) * ‖toLp u‖ * ‖toLp v‖ := by
    refine le_trans hbound (le_trans hschur (le_of_eq ?_))
    have : (Real.sqrt n * ‖toLp u‖) * (Real.sqrt n * ‖toLp v‖)
        = (Real.sqrt n * Real.sqrt n) * (‖toLp u‖ * ‖toLp v‖) := by ring
    rw [this, hnn]
    ring
  rcases eq_or_lt_of_le (norm_nonneg (toLp v)) with hz | hpos
  · rw [← hz]
    have h1 : (0:ℝ) ≤ (n : ℝ) := Nat.cast_nonneg n
    have h2 : (0:ℝ) ≤ ‖toLp u‖ := norm_nonneg _
    positivity
  · have := hkey
    nlinarith [hpos]
