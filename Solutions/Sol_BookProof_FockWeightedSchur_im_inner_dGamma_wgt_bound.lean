-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.im_inner_dGamma_wgt_bound
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Theorems.Thm_BookProof_FockWeightedSchur_annA_wgt
import Theorems.Thm_BookProof_FockWeightedSchur_inner_wgt_symm
import Theorems.Thm_BookProof_FockWeightedSchur_re_inner_wgt
import Theorems.Thm_BookProof_FockWeightedSchur_sum_wsq_normSq_annA
import Theorems.Thm_BookProof_FockWeightedSchur_w_pos
import Theorems.Thm_BookProof_FockWeightedSchur_wcomm_nonneg
import Theorems.Thm_BookProof_FockWeightedSchur_wcomm_row_le
import Theorems.Thm_BookProof_FockWeightedSchur_wcomm_col_le
import Theorems.Thm_BookProof_FockSchur_schur_test
import Theorems.Thm_BookProof_FockSecondQuantization_col_support_subset_closure
import Theorems.Thm_BookProof_FockSecondQuantization_inner_dGamma_left
import Theorems.Thm_BookProof_FockSecondQuantization_modes_left_subset_closure
import Theorems.Thm_BookProof_FockSecondQuantization_toLpL_apply
open BookProof.FockWeightedSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {w : ℕ → ℝ}
variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hw : ∀ k, 1 ≤ w k) (hherm : IsHermCol col)
    (hBg : WCommBound w col B) (u : FockAlg) :
    |(-2 : ℝ) * (inner ℂ (toLp (dGamma col u)) (toLp (wgt w u)) : ℂ).im|
      ≤ B * (inner ℂ (toLp u) (toLp (wgt w u)) : ℂ).re := by

  classical
  set N : FockAlg := wgt w u with hNdef
  set L : Finset ℕ := closureModes col u N with hLdef
  set z : ℂ := inner ℂ (toLp (dGamma col u)) (toLp N) with hzdef
  set f : ℕ → ℕ → ℂ := fun k j => (starRingEnd ℂ) ((col k) j)
    * inner ℂ (toLp (annA k u)) (toLp (wgt w (annA j u))) with hfdef
  set g : ℕ → ℕ → ℂ := fun k j => (starRingEnd ℂ) ((col k) j) * ((w j ^ 2 : ℝ) : ℂ)
    * inner ℂ (toLp (annA k u)) (toLp (annA j u)) with hgdef
  set p : ℕ → ℕ → ℂ := fun k j => (starRingEnd ℂ) ((col k) j) * ((w k ^ 2 : ℝ) : ℂ)
    * inner ℂ (toLp (annA k u)) (toLp (annA j u)) with hpdef
  have hexp : z = ∑ k ∈ L, ∑ j ∈ L, (starRingEnd ℂ) ((col k) j)
      * inner ℂ (toLp (annA k u)) (toLp (annA j N)) :=
    inner_dGamma_left col u N (modes_left_subset_closure col u N)
      (col_support_subset_closure col u N)
  have hterm : ∀ k j, (starRingEnd ℂ) ((col k) j)
      * (inner ℂ (toLp (annA k u)) (toLp (annA j N)) : ℂ) = f k j + g k j := by
    intro k j
    have hsplit : toLp (annA j N)
        = toLp (wgt w (annA j u)) + ((w j ^ 2 : ℝ) : ℂ) • toLp (annA j u) := by
      rw [hNdef, annA_wgt j u, ← toLpL_apply, map_add, map_smul, toLpL_apply, toLpL_apply]
    rw [hsplit, inner_add_right, inner_smul_right, hfdef, hgdef]
    ring
  set P : ℂ := ∑ k ∈ L, ∑ j ∈ L, f k j with hPdef
  set Q : ℂ := ∑ k ∈ L, ∑ j ∈ L, g k j with hQdef
  set R : ℂ := ∑ k ∈ L, ∑ j ∈ L, p k j with hRdef
  have hzPQ : z = P + Q := by
    rw [hexp, Finset.sum_congr rfl (fun k _ => Finset.sum_congr rfl (fun j _ => hterm k j)),
      hPdef, hQdef]
    simp only [Finset.sum_add_distrib]
  have hconjf : ∀ k j, (starRingEnd ℂ) (f k j) = f j k := by
    intro k j
    have h1 : (starRingEnd ℂ) ((starRingEnd ℂ) ((col k) j)) = (col k) j := by simp
    have h2 : (starRingEnd ℂ) (inner ℂ (toLp (annA k u)) (toLp (wgt w (annA j u))) : ℂ)
        = inner ℂ (toLp (wgt w (annA j u))) (toLp (annA k u)) := inner_conj_symm _ _
    have h3 : (inner ℂ (toLp (wgt w (annA j u))) (toLp (annA k u)) : ℂ)
        = inner ℂ (toLp (annA j u)) (toLp (wgt w (annA k u))) := inner_wgt_symm _ _
    have h4 : (starRingEnd ℂ) ((col j) k) = (col k) j := by rw [hherm j k]; simp
    simp only [hfdef]
    rw [map_mul, h1, h2, h3, h4]
  have hconjg : ∀ k j, (starRingEnd ℂ) (g k j) = p j k := by
    intro k j
    have h1 : (starRingEnd ℂ) ((starRingEnd ℂ) ((col k) j)) = (col k) j := by simp
    have h2 : (starRingEnd ℂ) (inner ℂ (toLp (annA k u)) (toLp (annA j u)) : ℂ)
        = inner ℂ (toLp (annA j u)) (toLp (annA k u)) := inner_conj_symm _ _
    have h4 : (starRingEnd ℂ) ((col j) k) = (col k) j := by rw [hherm j k]; simp
    simp only [hgdef, hpdef]
    rw [map_mul, map_mul, h1, Complex.conj_ofReal, h2, h4]
  have hconjP : (starRingEnd ℂ) P = P := by
    simp only [hPdef, map_sum]
    rw [Finset.sum_congr rfl (fun k _ => Finset.sum_congr rfl (fun j _ => hconjf k j))]
    exact Finset.sum_comm
  have hconjQ : (starRingEnd ℂ) Q = R := by
    simp only [hQdef, hRdef, map_sum]
    rw [Finset.sum_congr rfl (fun k _ => Finset.sum_congr rfl (fun j _ => hconjg k j))]
    exact Finset.sum_comm
  have hdiff : z - (starRingEnd ℂ) z = Q - R := by
    rw [hzPQ, map_add, hconjP, hconjQ]
    ring
  have hQR : Q - R = ∑ k ∈ L, ∑ j ∈ L, (starRingEnd ℂ) ((col k) j)
      * ((w j ^ 2 - w k ^ 2 : ℝ) : ℂ) * inner ℂ (toLp (annA k u)) (toLp (annA j u)) := by
    rw [hQdef, hRdef, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun j _ => ?_
    simp only [hgdef, hpdef]
    push_cast
    ring
  -- the Schur estimate of the surviving term
  set x : ℕ → ℝ := fun k => ‖toLp (annA k u)‖ with hxdef
  have hnorm : ‖Q - R‖ ≤ ∑ k ∈ L, ∑ j ∈ L,
      (‖(col k) j‖ * |w j ^ 2 - w k ^ 2| / (w k * w j)) * ((w k * x k) * (w j * x j)) := by
    rw [hQR]
    refine le_trans (norm_sum_le _ _) (Finset.sum_le_sum fun k _ => ?_)
    refine le_trans (norm_sum_le _ _) (Finset.sum_le_sum fun j _ => ?_)
    have hwk : w k ≠ 0 := (w_pos hw k).ne'
    have hwj : w j ≠ 0 := (w_pos hw j).ne'
    have hstep : ‖(starRingEnd ℂ) ((col k) j) * ((w j ^ 2 - w k ^ 2 : ℝ) : ℂ)
        * inner ℂ (toLp (annA k u)) (toLp (annA j u))‖
        ≤ ‖(col k) j‖ * |w j ^ 2 - w k ^ 2| * (x k * x j) := by
      rw [norm_mul, norm_mul, RCLike.norm_conj, Complex.norm_real, Real.norm_eq_abs]
      exact mul_le_mul_of_nonneg_left (norm_inner_le_norm _ _)
        (mul_nonneg (norm_nonneg _) (abs_nonneg _))
    refine le_trans hstep (le_of_eq ?_)
    field_simp
  have hB0 : 0 ≤ B := wcomm_nonneg hw hBg
  have hschur := schur_test (L := L)
    (m := fun k j => ‖(col k) j‖ * |w j ^ 2 - w k ^ 2| / (w k * w j))
    (x := fun k => w k * x k) (y := fun j => w j * x j) (K := B)
    (fun k j => by
      have : 0 < w k * w j := mul_pos (w_pos hw k) (w_pos hw j)
      positivity)
    (fun k => mul_nonneg (w_pos hw k).le (norm_nonneg _))
    (fun j => mul_nonneg (w_pos hw j).le (norm_nonneg _)) hB0
    (fun k => wcomm_row_le hw hBg k L) (fun j => wcomm_col_le hw hherm hBg j L)
  set S : ℝ := ∑ k ∈ L, (w k * x k) ^ 2 with hSdef
  have hS0 : 0 ≤ S := Finset.sum_nonneg fun k _ => sq_nonneg _
  have hsqrtS : Real.sqrt S * Real.sqrt S = S := Real.mul_self_sqrt hS0
  rw [hsqrtS] at hschur
  have hSval : S = ∑ α ∈ u.support, wdeg w α * ‖u α‖ ^ 2 := by
    have hid := sum_wsq_normSq_annA (w := w) (u := u) (L := L)
      (modes_left_subset_closure col u N)
    rw [hSdef, ← hid]
    exact Finset.sum_congr rfl fun k _ => by rw [hxdef]; ring
  have hSle : S ≤ (inner ℂ (toLp u) (toLp N) : ℂ).re := by
    rw [hSval, hNdef, re_inner_wgt]
    refine Finset.sum_le_sum fun α _ => ?_
    have : wdeg w α ≤ wSym w α := by simp only [wSym]; linarith
    exact mul_le_mul_of_nonneg_right this (sq_nonneg _)
  have habs : |(-2 : ℝ) * z.im| = ‖z - (starRingEnd ℂ) z‖ := by
    rw [Complex.sub_conj, norm_mul, Complex.norm_I, mul_one, Complex.norm_real,
      Real.norm_eq_abs, abs_mul, abs_mul]
    norm_num
  calc |(-2 : ℝ) * z.im| = ‖Q - R‖ := by rw [habs, hdiff]
    _ ≤ ∑ k ∈ L, ∑ j ∈ L, (‖(col k) j‖ * |w j ^ 2 - w k ^ 2| / (w k * w j))
          * ((w k * x k) * (w j * x j)) := hnorm
    _ ≤ B * S := hschur
    _ ≤ B * (inner ℂ (toLp u) (toLp N) : ℂ).re := mul_le_mul_of_nonneg_left hSle hB0
