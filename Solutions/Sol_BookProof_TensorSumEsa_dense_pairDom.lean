-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.dense_pairDom
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Theorems.Thm_BookProof_TensorCore_norm_tmul_sub_le
open BookProof.TensorSumEsa




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (hA : Dense (DA : Set Hs.carrier)) (hB : Dense (DB : Set Ks.carrier)) :
    Dense ((pairDom Hs Ks DA DB : Submodule ℂ (Hs.carrier ⊗[ℂ] Ks.carrier)) :
      Set (Hs.carrier ⊗[ℂ] Ks.carrier)) := by

  have hclosed : ∀ z : Hs.carrier ⊗[ℂ] Ks.carrier,
      z ∈ (pairDom Hs Ks DA DB).topologicalClosure := by
    have hpure : ∀ (x : Hs.carrier) (y : Ks.carrier),
        x ⊗ₜ[ℂ] y ∈ (pairDom Hs Ks DA DB).topologicalClosure := by
      intro x y
      change x ⊗ₜ[ℂ] y ∈ closure ((pairDom Hs Ks DA DB : Submodule ℂ _) : Set _)
      refine Metric.mem_closure_iff.mpr ?_
      intro ε hε
      set C : ℝ := ‖x‖ + ‖y‖ + 2 with hC
      have hCpos : 0 < C := by
        have := norm_nonneg x
        have := norm_nonneg y
        rw [hC]; linarith
      set δ : ℝ := min 1 (ε / (2 * C)) with hδ
      have hδpos : 0 < δ := lt_min one_pos (by positivity)
      have hδone : δ ≤ 1 := min_le_left _ _
      have hδC : δ * C < ε := by
        have h1 : δ ≤ ε / (2 * C) := min_le_right _ _
        have h2 : δ * C ≤ (ε / (2 * C)) * C := mul_le_mul_of_nonneg_right h1 hCpos.le
        have h3 : (ε / (2 * C)) * C = ε / 2 := by field_simp
        rw [h3] at h2
        linarith
      obtain ⟨a, haD, ha⟩ := Metric.mem_closure_iff.mp (hA.closure_eq ▸ Set.mem_univ x) δ hδpos
      obtain ⟨b, hbD, hb⟩ := Metric.mem_closure_iff.mp (hB.closure_eq ▸ Set.mem_univ y) δ hδpos
      have ha' : ‖x - a‖ < δ := by rwa [← dist_eq_norm]
      have hb' : ‖y - b‖ < δ := by rwa [← dist_eq_norm]
      have hanorm : ‖a‖ ≤ ‖x‖ + δ := by
        have h1 := norm_sub_norm_le a x
        have h2 : ‖a - x‖ < δ := by rw [norm_sub_rev]; exact ha'
        linarith
      refine ⟨(a : Hs.carrier) ⊗ₜ[ℂ] (b : Ks.carrier),
        ⟨(⟨a, haD⟩ : DA) ⊗ₜ[ℂ] (⟨b, hbD⟩ : DB), rfl⟩, ?_⟩
      rw [dist_eq_norm]
      have hmove := TensorCore.norm_tmul_sub_le x a y b
      have hb1 : ‖x - a‖ * ‖y‖ ≤ δ * ‖y‖ :=
        mul_le_mul_of_nonneg_right ha'.le (norm_nonneg _)
      have hb2 : ‖a‖ * ‖y - b‖ ≤ (‖x‖ + δ) * δ :=
        mul_le_mul hanorm hb'.le (norm_nonneg _) (by
          have := norm_nonneg x; linarith)
      have hbudget : δ * ‖y‖ + (‖x‖ + δ) * δ ≤ δ * C := by
        have hfac : δ * C - (δ * ‖y‖ + (‖x‖ + δ) * δ) = δ * (2 - δ) := by rw [hC]; ring
        have hnn : 0 ≤ δ * (2 - δ) := mul_nonneg hδpos.le (by linarith)
        linarith
      linarith
    intro z
    have hz : z ∈ Submodule.span ℂ
        {t : Hs.carrier ⊗[ℂ] Ks.carrier |
          ∃ (p : Hs.carrier) (q : Ks.carrier), p ⊗ₜ[ℂ] q = t} := by
      rw [TensorProduct.span_tmul_eq_top]; trivial
    induction hz using Submodule.span_induction with
    | mem t ht => obtain ⟨p, q, rfl⟩ := ht; exact hpure p q
    | zero => exact Submodule.zero_mem _
    | add s t _ _ hs ht => exact Submodule.add_mem _ hs ht
    | smul c s _ hs => exact Submodule.smul_mem _ c hs
  rw [dense_iff_closure_eq]
  apply Set.eq_univ_of_forall
  exact hclosed
