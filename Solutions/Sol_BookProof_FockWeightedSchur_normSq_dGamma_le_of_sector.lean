-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.normSq_dGamma_le_of_sector
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Theorems.Thm_BookProof_FockWeightedSchur_wdeg_nonneg
import Theorems.Thm_BookProof_FockWeightedSchur_sum_wsq_normSq_annA
import Theorems.Thm_BookProof_FockWeightedSchur_w_pos
import Theorems.Thm_BookProof_FockWeightedSchur_wrow_le
import Theorems.Thm_BookProof_FockWeightedSchur_wcol_le
open BookProof.FockWeightedSchur














open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section




variable {w : ℕ → ℝ}

















variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hw : ∀ k, 1 ≤ w k) (hherm : IsHermCol col)
    (hrow : WRowBound w col K) (hcolg : WColBound w col K) (hK0 : 0 ≤ K)
    {n : ℕ} {u : FockAlg} (hu : InSector n u) :
    ‖toLp (dGamma col u)‖ ^ 2 ≤ K ^ 2 * ((n : ℝ) * ∑ α ∈ u.support, wdeg w α * ‖u α‖ ^ 2) := by

  classical
  set v : FockAlg := dGamma col u with hv
  have hvsec : InSector n v := dGamma_inSector col hu
  set L : Finset ℕ := closureModes col u v with hLdef
  set Q : ℝ := ∑ α ∈ u.support, wdeg w α * ‖u α‖ ^ 2 with hQdef
  have hQ0 : 0 ≤ Q := Finset.sum_nonneg fun α _ =>
    mul_nonneg (wdeg_nonneg α) (sq_nonneg _)
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
  have hschur := schur_test (L := L) (m := fun k j => ‖(col k) j‖ / w k)
    (x := fun k => w k * ‖toLp (annA k u)‖) (y := fun j => ‖toLp (annA j v)‖) (K := K)
    (fun k j => div_nonneg (norm_nonneg _) (w_pos hw k).le)
    (fun k => mul_nonneg (w_pos hw k).le (norm_nonneg _)) (fun j => norm_nonneg _) hK0
    (fun k => wrow_le hw hrow k L) (fun j => wcol_le hw hherm hcolg j L)
  have hLHS : ∑ k ∈ L, ∑ j ∈ L, (‖(col k) j‖ / w k)
      * ((w k * ‖toLp (annA k u)‖) * ‖toLp (annA j v)‖)
      = ∑ k ∈ L, ∑ j ∈ L, ‖(col k) j‖ * (‖toLp (annA k u)‖ * ‖toLp (annA j v)‖) := by
    refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun j _ => ?_
    have hwk : w k ≠ 0 := (w_pos hw k).ne'
    field_simp
  have hxsum : ∑ k ∈ L, (w k * ‖toLp (annA k u)‖) ^ 2 = Q := by
    have hid := sum_wsq_normSq_annA (w := w) (u := u) (L := L)
      (modes_left_subset_closure col u v)
    rw [hQdef, ← hid]
    exact Finset.sum_congr rfl fun k _ => by ring
  have hysum : ∑ j ∈ L, ‖toLp (annA j v)‖ ^ 2 = (n : ℝ) * ‖toLp v‖ ^ 2 :=
    sum_normSq_annA_of_sector hvsec (modes_right_subset_closure col u v)
  rw [hLHS, hxsum, hysum] at hschur
  have hsqrtv : Real.sqrt ((n : ℝ) * ‖toLp v‖ ^ 2) = Real.sqrt n * ‖toLp v‖ := by
    rw [Real.sqrt_mul (Nat.cast_nonneg n), Real.sqrt_sq (norm_nonneg _)]
  rw [hsqrtv] at hschur
  have hkey : ‖toLp v‖ ^ 2 ≤ K * (Real.sqrt Q * (Real.sqrt n * ‖toLp v‖)) :=
    le_trans hbound hschur
  have hsq : Real.sqrt Q ^ 2 = Q := Real.sq_sqrt hQ0
  have hsn : Real.sqrt n ^ 2 = (n : ℝ) := Real.sq_sqrt (Nat.cast_nonneg n)
  have hQs : 0 ≤ Real.sqrt Q := Real.sqrt_nonneg _
  have hns : 0 ≤ Real.sqrt n := Real.sqrt_nonneg _
  rcases eq_or_lt_of_le (norm_nonneg (toLp v)) with hz | hpos
  · rw [← hz]
    simpa using mul_nonneg (sq_nonneg K) (mul_nonneg (Nat.cast_nonneg n) hQ0)
  · have hle : ‖toLp v‖ ≤ K * (Real.sqrt Q * Real.sqrt n) := by
      nlinarith [hkey, hpos]
    have hRnn : 0 ≤ K * (Real.sqrt Q * Real.sqrt n) :=
      mul_nonneg hK0 (mul_nonneg hQs hns)
    calc ‖toLp v‖ ^ 2 ≤ (K * (Real.sqrt Q * Real.sqrt n)) ^ 2 := by nlinarith [hle, hpos]
      _ = K ^ 2 * ((n : ℝ) * Q) := by
          rw [mul_pow, mul_pow, hsq, hsn]; ring
