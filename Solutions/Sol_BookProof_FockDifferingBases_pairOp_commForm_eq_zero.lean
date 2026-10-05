-- Generated from ChapterFockDifferingBasesEsa.lean — solution of BookProof.FockDifferingBases.pairOp_commForm_eq_zero
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
import Theorems.Thm_BookProof_FockDifferingBases_sig_tgt_eq_of_balanced
import Theorems.Thm_BookProof_OperatorSeries_commForm_eq_neg_two_im
open BookProof.FockDifferingBases




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}

variable {ι κ : Type*} {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hω : ∀ i, 0 ≤ ω i) (g : ℂ) (P Q : Idx ι)
    (hPQ : deg P + deg Q ≤ 2) (hbal : Balanced ω P Q) (x : maxDom (sig ω)) :
    commForm (pairOp hω g P Q hPQ) (diagMax (sig ω)) x = 0 := by

  classical
  have hQP : deg Q + deg P ≤ 2 := by omega
  set xb : Idx ι → ℂ := ((x : L2I (Idx ι)) : Idx ι → ℂ) with hxb
  set t : Idx ι → ℂ := hopT P Q xb with htdef
  set A : ℂ := inner ℂ (hopOp hω P Q hPQ x : L2I (Idx ι))
    (diagMax (sig ω) x : L2I (Idx ι)) with hAdef
  set B : ℂ := inner ℂ (hopOp hω Q P hQP x : L2I (Idx ι))
    (diagMax (sig ω) x : L2I (Idx ι)) with hBdef
  have hA : HasSum (fun b : {b : Idx ι // P ≤ b} =>
      (sig ω (b : Idx ι) : ℂ) * t (b : Idx ι)) A := by
    have h := lp.hasSum_inner (𝕜 := ℂ) (hopOp hω P Q hPQ x : L2I (Idx ι))
      (diagMax (sig ω) x : L2I (Idx ι))
    have hvan : ∀ b : Idx ι, b ∉ Set.range (Subtype.val : {b : Idx ι // P ≤ b} → Idx ι) →
        (inner ℂ (((hopOp hω P Q hPQ x : L2I (Idx ι)) : Idx ι → ℂ) b)
          (((diagMax (sig ω) x : L2I (Idx ι)) : Idx ι → ℂ) b) : ℂ) = 0 := by
      intro b hb
      have hnp : ¬ P ≤ b := fun hle => hb ⟨⟨b, hle⟩, rfl⟩
      simp [RCLike.inner_apply, amp_eq_zero_of_not_le hnp]
    have h2 := ((Subtype.coe_injective (p := fun b : Idx ι => P ≤ b)).hasSum_iff hvan).mpr h
    refine h2.congr_fun ?_
    intro b
    simp only [Function.comp_apply, RCLike.inner_apply, hopOp_coe, diagMax_coe, htdef, hopT,
      map_mul, Complex.conj_ofReal, hxb]
    ring
  have hB : HasSum (fun b : {b : Idx ι // P ≤ b} =>
      (sig ω (tgt P Q (b : Idx ι)) : ℂ) * (starRingEnd ℂ) (t (b : Idx ι))) B := by
    have h := lp.hasSum_inner (𝕜 := ℂ) (hopOp hω Q P hQP x : L2I (Idx ι))
      (diagMax (sig ω) x : L2I (Idx ι))
    have hvan : ∀ a : Idx ι,
        a ∉ Set.range (fun b : {b : Idx ι // P ≤ b} => tgt P Q (b : Idx ι)) →
        (inner ℂ (((hopOp hω Q P hQP x : L2I (Idx ι)) : Idx ι → ℂ) a)
          (((diagMax (sig ω) x : L2I (Idx ι)) : Idx ι → ℂ) a) : ℂ) = 0 := by
      intro a ha
      have hnq : ¬ Q ≤ a := fun hle => ha ⟨⟨tgt Q P a, le_tgt Q P a⟩, tgt_tgt hle⟩
      simp [RCLike.inner_apply, amp_eq_zero_of_not_le hnq]
    have h2 := ((hop_injective P Q).hasSum_iff hvan).mpr h
    refine h2.congr_fun ?_
    intro b
    simp only [Function.comp_apply, RCLike.inner_apply, hopOp_coe, diagMax_coe]
    rw [amp_symm b.2, tgt_tgt b.2]
    simp only [htdef, hopT, map_mul, Complex.conj_ofReal, Complex.conj_conj, hxb]
    ring
  -- with the balance hypothesis the second sum is the conjugate of the first
  have hBconj : B = (starRingEnd ℂ) A := by
    refine hB.unique ?_
    have hstar := hA.star
    refine hstar.congr_fun ?_
    intro b
    rw [sig_tgt_eq_of_balanced hbal b.2]
    simp [RCLike.star_def, Complex.conj_ofReal]
  have hinner : (inner ℂ (pairOp hω g P Q hPQ x : L2I (Idx ι))
      (diagMax (sig ω) x : L2I (Idx ι)) : ℂ) = (starRingEnd ℂ) g * A + g * B := by
    simp only [pairOp, LinearMap.add_apply, LinearMap.smul_apply, inner_add_left, inner_smul_left,
      hAdef, hBdef, Complex.conj_conj]
  have hreal : ((starRingEnd ℂ) g * A + g * B).im = 0 := by
    rw [hBconj]
    have hrw : (starRingEnd ℂ) g * A + g * (starRingEnd ℂ) A
        = ((starRingEnd ℂ) g * A) + (starRingEnd ℂ) ((starRingEnd ℂ) g * A) := by
      simp [map_mul]
    rw [hrw, Complex.add_conj]
    simp
  rw [commForm_eq_neg_two_im, hinner, hreal]
  ring
