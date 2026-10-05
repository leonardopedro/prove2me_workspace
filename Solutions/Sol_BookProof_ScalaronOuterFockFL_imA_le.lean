-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.imA_le
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Theorems.Thm_BookProof_ScalaronOuterFockFL_ham_eq_ham_zero_add
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
  set T1 : ℂ := ∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.A a b) *
    (inner ℂ ((u b : ccDomain ℝ) : L2R) (W.ham 0 (u a)) : ℂ) with hT1def
  set T2 : ℂ := ∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.A a b) *
    (((Q.sig a : ℝ) : ℂ) * (inner ℂ ((u b : ccDomain ℝ) : L2R) ((u a : ccDomain ℝ) : L2R) : ℂ))
    with hT2def
  have hsplit : (∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.A a b) *
      (inner ℂ ((u b : ccDomain ℝ) : L2R) (W.ham (Q.sig a) (u a)) : ℂ)) = T1 + T2 := by
    rw [hT1def, hT2def, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [ham_eq_ham_zero_add W (Q.sig a) (u a), inner_add_right, inner_smul_right]
    ring
  -- the `h₀` part is real
  have hT1real : (starRingEnd ℂ) T1 = T1 := by
    rw [hT1def]
    simp only [map_sum, map_mul, RingHomCompTriple.comp_apply, RingHom.id_apply]
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    rw [Q.A_herm a b, inner_conj_symm, W.ham_symmetricOn 0 (u b) (u a)]
  have hT1im : T1.im = 0 := Complex.conj_eq_iff_im.mp hT1real
  -- the shift part is controlled by the commutator hypothesis on `A`
  have hconjT2 : (starRingEnd ℂ) T2 = ∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.A a b) *
      (((Q.sig b : ℝ) : ℂ) *
        (inner ℂ ((u b : ccDomain ℝ) : L2R) ((u a : ccDomain ℝ) : L2R) : ℂ)) := by
    rw [hT2def]
    simp only [map_sum, map_mul, RingHomCompTriple.comp_apply, RingHom.id_apply,
      Complex.conj_ofReal]
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    rw [Q.A_herm a b, inner_conj_symm]
  have hdiff : T2 - (starRingEnd ℂ) T2 = ∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.A a b) *
      ((((Q.sig a - Q.sig b : ℝ)) : ℂ) *
        (inner ℂ ((u b : ccDomain ℝ) : L2R) ((u a : ccDomain ℝ) : L2R) : ℂ)) := by
    rw [hT2def, hconjT2, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    push_cast
    ring
  have hbound : ‖T2 - (starRingEnd ℂ) T2‖
      ≤ ∑ a ∈ P, ∑ b ∈ P, (‖Q.A a b‖ * |Q.sig a - Q.sig b|) *
        (‖((u a : ccDomain ℝ) : L2R)‖ * ‖((u b : ccDomain ℝ) : L2R)‖) := by
    rw [hdiff]
    refine le_trans (norm_sum_le _ _) (Finset.sum_le_sum fun a _ => ?_)
    refine le_trans (norm_sum_le _ _) (Finset.sum_le_sum fun b _ => ?_)
    have hcs : ‖(inner ℂ ((u b : ccDomain ℝ) : L2R) ((u a : ccDomain ℝ) : L2R) : ℂ)‖
        ≤ ‖((u a : ccDomain ℝ) : L2R)‖ * ‖((u b : ccDomain ℝ) : L2R)‖ := by
      rw [mul_comm]
      exact norm_inner_le_norm _ _
    rw [norm_mul, norm_mul, RCLike.norm_conj, Complex.norm_real, Real.norm_eq_abs, mul_assoc]
    exact mul_le_mul_of_nonneg_left (mul_le_mul_of_nonneg_left hcs (abs_nonneg _))
      (norm_nonneg _)
  -- the Schur bounds for the weight
  have hwnn : ∀ a b, 0 ≤ ‖Q.A a b‖ * |Q.sig a - Q.sig b| := fun a b =>
    mul_nonneg (norm_nonneg _) (abs_nonneg _)
  have hwsymm : ∀ a b, ‖Q.A a b‖ * |Q.sig a - Q.sig b| = ‖Q.A b a‖ * |Q.sig b - Q.sig a| := by
    intro a b
    rw [Q.A_herm a b, RCLike.norm_conj, abs_sub_comm]
  have hrow : ∀ a, ∑ b ∈ P, ‖Q.A a b‖ * |Q.sig a - Q.sig b| ≤ Q.K * Q.sig a := by
    intro a
    refine le_trans (sum_le_sum_band P (Q.nbr a) _ (fun b => hwnn a b) fun b hb => ?_) ?_
    · rw [Q.A_off a b hb, norm_zero, zero_mul]
    · refine le_trans (le_of_eq (Finset.sum_congr rfl fun b _ => mul_comm _ _)) (Q.A_comm a)
  have hcol : ∀ b, ∑ a ∈ P, ‖Q.A a b‖ * |Q.sig a - Q.sig b| ≤ Q.K * Q.sig b := by
    intro b
    rw [Finset.sum_congr rfl fun a _ => hwsymm a b]
    exact hrow b
  have hamgm := double_sum_amgm P (fun a b => ‖Q.A a b‖ * |Q.sig a - Q.sig b|)
    (fun a => ‖((u a : ccDomain ℝ) : L2R)‖) (fun b => ‖((u b : ccDomain ℝ) : L2R)‖)
    (fun a => Q.K * Q.sig a) hwnn hrow hcol
  have hq : ∀ a, Q.K * Q.sig a * ‖((u a : ccDomain ℝ) : L2R)‖ ^ 2
      ≤ Q.K * quadForm (W.ham (Q.sig a)) (u a) := by
    intro a
    have h := sig_mul_norm_sq_le_quadForm W (Q.sig a) (u a)
    have : Q.K * (Q.sig a * ‖((u a : ccDomain ℝ) : L2R)‖ ^ 2)
        ≤ Q.K * quadForm (W.ham (Q.sig a)) (u a) :=
      mul_le_mul_of_nonneg_left h Q.K_nonneg
    linarith [this]
  have hsum : ∑ a ∈ P, Q.K * Q.sig a * ‖((u a : ccDomain ℝ) : L2R)‖ ^ 2
      ≤ Q.K * ∑ a ∈ P, quadForm (W.ham (Q.sig a)) (u a) := by
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun a _ => hq a
  have hfinal : ‖T2 - (starRingEnd ℂ) T2‖ ≤ Q.K * ∑ a ∈ P, quadForm (W.ham (Q.sig a)) (u a) := by
    refine le_trans hbound (le_trans hamgm ?_)
    linarith [hsum]
  rw [hsplit]
  have him : (T1 + T2).im = T2.im := by
    rw [Complex.add_im, hT1im, zero_add]
  rw [him]
  have h2 := norm_sub_conj_eq T2
  rw [h2] at hfinal
  linarith
