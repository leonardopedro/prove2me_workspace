-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.imB_le
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Theorems.Thm_BookProof_ScalaronOuterFockFL_ham_eq_ham_zero_add
import Theorems.Thm_BookProof_ScalaronOuterFockFL_norm_sq_le_quadForm_cc
import Theorems.Thm_BookProof_ScalaronOuterFockFL_norm_dCc_sq_le_cc
import Theorems.Thm_BookProof_ScalaronOuterFockFL_ham_x_comm_cc
import Theorems.Thm_BookProof_ScalaronOuterFockFL_double_sum_amgm
import Theorems.Thm_BookProof_ScalaronOuterFockFL_norm_sub_conj_eq
open BookProof.ScalaronOuterFockFL




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (W : WallPot) (s : ℝ)
variable {ι : Type*}
variable (Q : QgModeData ι)
variable (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in
theorem solution (x : secCore (ι := by

  classical
  set u : ι → ccDomain ℝ := fun a => fibOf x a with hu
  set U : ℂ := ∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.B a b) *
    (inner ℂ (xCc (u b)) (W.ham (Q.sig a) (u a)) : ℂ) with hUdef
  set S : ℝ := ∑ a ∈ P, quadForm (W.ham (Q.sig a)) (u a) with hSdef
  have hUswap : U = ∑ a ∈ P, ∑ b ∈ P, Q.B a b *
      (inner ℂ (xCc (u a)) (W.ham (Q.sig b) (u b)) : ℂ) := by
    rw [hUdef, Finset.sum_comm]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    rw [Q.B_herm a b]
    simp
  have hconjU : (starRingEnd ℂ) U = ∑ a ∈ P, ∑ b ∈ P, Q.B a b *
      ((inner ℂ (xCc (u a)) (W.ham (Q.sig a) (u b)) : ℂ)
        - 2 * (inner ℂ ((u a : ccDomain ℝ) : L2R) (dCc (u b)) : ℂ)) := by
    rw [hUdef]
    simp only [map_sum, map_mul, RingHomCompTriple.comp_apply, RingHom.id_apply]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    congr 1
    have h := ham_x_comm_cc W (Q.sig a) (u a) (u b)
    linear_combination h
  have hfibdiff : ∀ a b, (inner ℂ (xCc (u a)) (W.ham (Q.sig b) (u b)) : ℂ)
      - (inner ℂ (xCc (u a)) (W.ham (Q.sig a) (u b)) : ℂ)
      = (((Q.sig b - Q.sig a : ℝ)) : ℂ) *
        (inner ℂ (xCc (u a)) ((u b : ccDomain ℝ) : L2R) : ℂ) := by
    intro a b
    rw [ham_eq_ham_zero_add W (Q.sig b) (u b), ham_eq_ham_zero_add W (Q.sig a) (u b),
      inner_add_right, inner_add_right, inner_smul_right, inner_smul_right]
    push_cast
    ring
  have hdiff : U - (starRingEnd ℂ) U = ∑ a ∈ P, ∑ b ∈ P, Q.B a b *
      ((((Q.sig b - Q.sig a : ℝ)) : ℂ) *
          (inner ℂ (xCc (u a)) ((u b : ccDomain ℝ) : L2R) : ℂ)
        + 2 * (inner ℂ ((u a : ccDomain ℝ) : L2R) (dCc (u b)) : ℂ)) := by
    rw [hconjU, hUswap, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    linear_combination (Q.B a b) * hfibdiff a b
  -- termwise bound
  have hterm : ∀ a b, ‖Q.B a b *
      ((((Q.sig b - Q.sig a : ℝ)) : ℂ) *
          (inner ℂ (xCc (u a)) ((u b : ccDomain ℝ) : L2R) : ℂ)
        + 2 * (inner ℂ ((u a : ccDomain ℝ) : L2R) (dCc (u b)) : ℂ))‖
      ≤ (‖Q.B a b‖ * |Q.sig a - Q.sig b|) * (‖xCc (u a)‖ * ‖((u b : ccDomain ℝ) : L2R)‖)
        + 2 * (‖Q.B a b‖ * (‖((u a : ccDomain ℝ) : L2R)‖ * ‖dCc (u b)‖)) := by
    intro a b
    have h1 : ‖(((Q.sig b - Q.sig a : ℝ)) : ℂ) *
        (inner ℂ (xCc (u a)) ((u b : ccDomain ℝ) : L2R) : ℂ)‖
        ≤ |Q.sig a - Q.sig b| * (‖xCc (u a)‖ * ‖((u b : ccDomain ℝ) : L2R)‖) := by
      rw [norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_sub_comm]
      exact mul_le_mul_of_nonneg_left (norm_inner_le_norm _ _) (abs_nonneg _)
    have h2 : ‖(2 : ℂ) * (inner ℂ ((u a : ccDomain ℝ) : L2R) (dCc (u b)) : ℂ)‖
        ≤ 2 * (‖((u a : ccDomain ℝ) : L2R)‖ * ‖dCc (u b)‖) := by
      rw [norm_mul]
      have : ‖(2 : ℂ)‖ = 2 := by norm_num
      rw [this]
      exact mul_le_mul_of_nonneg_left (norm_inner_le_norm _ _) (by norm_num)
    calc ‖Q.B a b * ((((Q.sig b - Q.sig a : ℝ)) : ℂ) *
            (inner ℂ (xCc (u a)) ((u b : ccDomain ℝ) : L2R) : ℂ)
          + 2 * (inner ℂ ((u a : ccDomain ℝ) : L2R) (dCc (u b)) : ℂ))‖
        = ‖Q.B a b‖ * ‖(((Q.sig b - Q.sig a : ℝ)) : ℂ) *
            (inner ℂ (xCc (u a)) ((u b : ccDomain ℝ) : L2R) : ℂ)
          + 2 * (inner ℂ ((u a : ccDomain ℝ) : L2R) (dCc (u b)) : ℂ)‖ := norm_mul _ _
      _ ≤ ‖Q.B a b‖ * (|Q.sig a - Q.sig b| * (‖xCc (u a)‖ * ‖((u b : ccDomain ℝ) : L2R)‖)
            + 2 * (‖((u a : ccDomain ℝ) : L2R)‖ * ‖dCc (u b)‖)) := by
          refine mul_le_mul_of_nonneg_left ?_ (norm_nonneg _)
          exact le_trans (norm_add_le _ _) (by linarith)
      _ = (‖Q.B a b‖ * |Q.sig a - Q.sig b|) *
            (‖xCc (u a)‖ * ‖((u b : ccDomain ℝ) : L2R)‖)
          + 2 * (‖Q.B a b‖ * (‖((u a : ccDomain ℝ) : L2R)‖ * ‖dCc (u b)‖)) := by ring
  have hnormsum : ‖U - (starRingEnd ℂ) U‖
      ≤ (∑ a ∈ P, ∑ b ∈ P, (‖Q.B a b‖ * |Q.sig a - Q.sig b|) *
            (‖xCc (u a)‖ * ‖((u b : ccDomain ℝ) : L2R)‖))
        + 2 * ∑ a ∈ P, ∑ b ∈ P, ‖Q.B a b‖ *
            (‖((u a : ccDomain ℝ) : L2R)‖ * ‖dCc (u b)‖) := by
    rw [hdiff]
    refine le_trans (le_trans (norm_sum_le _ _)
      (Finset.sum_le_sum fun a _ => norm_sum_le _ _)) ?_
    have hstep : ∑ a ∈ P, ∑ b ∈ P, ‖Q.B a b *
        ((((Q.sig b - Q.sig a : ℝ)) : ℂ) *
            (inner ℂ (xCc (u a)) ((u b : ccDomain ℝ) : L2R) : ℂ)
          + 2 * (inner ℂ ((u a : ccDomain ℝ) : L2R) (dCc (u b)) : ℂ))‖
        ≤ ∑ a ∈ P, ∑ b ∈ P, ((‖Q.B a b‖ * |Q.sig a - Q.sig b|) *
              (‖xCc (u a)‖ * ‖((u b : ccDomain ℝ) : L2R)‖)
            + 2 * (‖Q.B a b‖ * (‖((u a : ccDomain ℝ) : L2R)‖ * ‖dCc (u b)‖))) :=
      Finset.sum_le_sum fun a _ => Finset.sum_le_sum fun b _ => hterm a b
    refine le_trans hstep (le_of_eq ?_)
    rw [Finset.mul_sum]
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.sum_add_distrib, Finset.mul_sum]
  -- the two Schur bounds
  have hBnn : ∀ a b, 0 ≤ ‖Q.B a b‖ := fun a b => norm_nonneg _
  have hBsymm : ∀ a b, ‖Q.B a b‖ = ‖Q.B b a‖ := by
    intro a b
    rw [Q.B_herm a b, RCLike.norm_conj]
  have hw1nn : ∀ a b, 0 ≤ ‖Q.B a b‖ * |Q.sig a - Q.sig b| := fun a b =>
    mul_nonneg (norm_nonneg _) (abs_nonneg _)
  have hw1symm : ∀ a b, ‖Q.B a b‖ * |Q.sig a - Q.sig b| = ‖Q.B b a‖ * |Q.sig b - Q.sig a| := by
    intro a b
    rw [← hBsymm a b, abs_sub_comm]
  have hrow1 : ∀ a, ∑ b ∈ P, ‖Q.B a b‖ * |Q.sig a - Q.sig b| ≤ Q.K := by
    intro a
    refine le_trans (sum_le_sum_band P (Q.nbr a) _ (fun b => hw1nn a b) fun b hb => ?_) ?_
    · rw [Q.B_off a b hb, norm_zero, zero_mul]
    · refine le_trans (le_of_eq (Finset.sum_congr rfl fun b _ => mul_comm _ _)) (Q.B_comm a)
  have hcol1 : ∀ b, ∑ a ∈ P, ‖Q.B a b‖ * |Q.sig a - Q.sig b| ≤ Q.K := by
    intro b
    rw [Finset.sum_congr rfl fun a _ => hw1symm a b]
    exact hrow1 b
  have hrow2 : ∀ a, ∑ b ∈ P, ‖Q.B a b‖ ≤ Q.K := by
    intro a
    refine le_trans (sum_le_sum_band P (Q.nbr a) _ (fun b => hBnn a b) fun b hb => ?_)
      (Q.B_rel a)
    rw [Q.B_off a b hb, norm_zero]
  have hcol2 : ∀ b, ∑ a ∈ P, ‖Q.B a b‖ ≤ Q.K := by
    intro b
    rw [Finset.sum_congr rfl fun a _ => hBsymm a b]
    exact hrow2 b
  have hS1 := double_sum_amgm P (fun a b => ‖Q.B a b‖ * |Q.sig a - Q.sig b|)
    (fun a => ‖xCc (u a)‖) (fun b => ‖((u b : ccDomain ℝ) : L2R)‖) (fun _ => Q.K)
    hw1nn hrow1 hcol1
  have hS2 := double_sum_amgm P (fun a b => ‖Q.B a b‖)
    (fun a => ‖((u a : ccDomain ℝ) : L2R)‖) (fun b => ‖dCc (u b)‖) (fun _ => Q.K)
    hBnn hrow2 hcol2
  -- the fibre estimates
  have hxc : ∑ a ∈ P, Q.K * ‖xCc (u a)‖ ^ 2 ≤ 4 * Q.K * S := by
    rw [hSdef, mul_assoc, Finset.mul_sum, Finset.mul_sum]
    refine Finset.sum_le_sum fun a _ => ?_
    have h := norm_xCc_sq_le_cc W (Q.sig a) (Q.sig_nonneg a) (u a)
    have hk := mul_le_mul_of_nonneg_left h Q.K_nonneg
    linarith
  have hnrm : ∑ a ∈ P, Q.K * ‖((u a : ccDomain ℝ) : L2R)‖ ^ 2 ≤ Q.K * S := by
    rw [hSdef, Finset.mul_sum]
    refine Finset.sum_le_sum fun a _ => ?_
    have h := norm_sq_le_quadForm_cc W (Q.sig a) (Q.one_le_sig a) (u a)
    exact mul_le_mul_of_nonneg_left h Q.K_nonneg
  have hder : ∑ a ∈ P, Q.K * ‖dCc (u a)‖ ^ 2 ≤ Q.K * S := by
    rw [hSdef, Finset.mul_sum]
    refine Finset.sum_le_sum fun a _ => ?_
    have h := norm_dCc_sq_le_cc W (Q.sig a) (Q.sig_nonneg a) (u a)
    exact mul_le_mul_of_nonneg_left h Q.K_nonneg
  have hfinal : ‖U - (starRingEnd ℂ) U‖ ≤ (9 / 2) * Q.K * S := by
    refine le_trans hnormsum ?_
    have e1 := hS1
    have e2 := hS2
    linarith
  have h2 := norm_sub_conj_eq U
  rw [h2] at hfinal
  linarith
