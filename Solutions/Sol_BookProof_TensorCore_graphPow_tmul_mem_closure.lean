-- Generated from ChapterTensorGraphCore.lean — solution of BookProof.TensorCore.graphPow_tmul_mem_closure
import Mathlib
import Definitions.Def_ChapterTensorGraphCore
import Theorems.Thm_BookProof_TensorCore_tmul_mem_corePow
import Theorems.Thm_BookProof_TensorCore_norm_tmul_sub_le
open BookProof.TensorCore




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)
variable (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (hcore : IsGraphCore D A) (n : ℕ)
    (ih : ∀ b : ((domSpace Hs D₂).pow n), graphPow Hs D₂ A n b ∈
      (Submodule.map (graphPow Hs D₂ A n) (corePow Hs D₂ D n)).topologicalClosure)
    (a : D₂) (b : ((domSpace Hs D₂).pow n)) :
    graphPow Hs D₂ A (n + 1) (a ⊗ₜ[ℂ] b) ∈
      (Submodule.map (graphPow Hs D₂ A (n + 1))
        (corePow Hs D₂ D (n + 1))).topologicalClosure := by

  change graphPow Hs D₂ A (n + 1) (a ⊗ₜ[ℂ] b) ∈
    closure ((Submodule.map (graphPow Hs D₂ A (n + 1)) (corePow Hs D₂ D (n + 1))) : Set _)
  refine Metric.mem_closure_iff.mpr ?_
  intro ε hε
  set u : (Hs.pow n).carrier := inclPow Hs D₂ n b with hu
  set w : (Hs.pow n).carrier := derPow Hs D₂ A n b with hw
  set na : ℝ := ‖(a : Hs.carrier)‖ with hna
  set nAa : ℝ := ‖A a‖ with hnAa
  set C : ℝ := na + nAa + ‖u‖ + ‖w‖ + 2 with hC
  have hna0 : 0 ≤ na := norm_nonneg _
  have hnAa0 : 0 ≤ nAa := norm_nonneg _
  have hu0 : 0 ≤ ‖u‖ := norm_nonneg _
  have hw0 : 0 ≤ ‖w‖ := norm_nonneg _
  have hCpos : 0 < C := by rw [hC]; linarith
  set δ : ℝ := min 1 (ε / (2 * C)) with hδ
  have hδpos : 0 < δ := lt_min one_pos (by positivity)
  have hδone : δ ≤ 1 := min_le_left _ _
  have hδC : δ * C < ε := by
    have h1 : δ ≤ ε / (2 * C) := min_le_right _ _
    have h2 : δ * C ≤ (ε / (2 * C)) * C := mul_le_mul_of_nonneg_right h1 hCpos.le
    have h3 : (ε / (2 * C)) * C = ε / 2 := by field_simp
    rw [h3] at h2
    linarith
  -- approximate the head factor inside the one-particle core
  obtain ⟨a', ha'D, ha'₁, ha'₂⟩ := hcore a δ hδpos
  -- approximate the tail inside the core tensor power
  obtain ⟨z, hz, hzd⟩ := Metric.mem_closure_iff.mp (ih b) δ hδpos
  obtain ⟨b', hb', rfl⟩ := hz
  set u' : (Hs.pow n).carrier := inclPow Hs D₂ n b' with hu'
  set w' : (Hs.pow n).carrier := derPow Hs D₂ A n b' with hw'
  have hzd' := max_lt_iff.mp (by simpa [Prod.dist_eq, dist_eq_norm] using hzd)
  have hb₁ : ‖u - u'‖ < δ := by simpa [hu, hu'] using hzd'.1
  have hb₂ : ‖w - w'‖ < δ := by simpa [hw, hw'] using hzd'.2
  have ha'norm : ‖(a' : Hs.carrier)‖ ≤ na + δ := by
    have h1 := norm_sub_norm_le (a' : Hs.carrier) (a : Hs.carrier)
    have h2 : ‖(a' : Hs.carrier) - (a : Hs.carrier)‖ < δ := by rw [norm_sub_rev]; exact ha'₁
    rw [hna]; linarith
  have hAa'norm : ‖A a'‖ ≤ nAa + δ := by
    have h1 := norm_sub_norm_le (A a') (A a)
    have h2 : ‖A a' - A a‖ < δ := by rw [norm_sub_rev]; exact ha'₂
    rw [hnAa]; linarith
  refine ⟨graphPow Hs D₂ A (n + 1) (a' ⊗ₜ[ℂ] b'),
    ⟨a' ⊗ₜ[ℂ] b', tmul_mem_corePow Hs D₂ D ha'D hb', rfl⟩, ?_⟩
  -- the three elementary moves
  have hmove₁ : ‖(a : Hs.carrier) ⊗ₜ[ℂ] u - (a' : Hs.carrier) ⊗ₜ[ℂ] u'‖
      ≤ δ * ‖u‖ + (na + δ) * δ := by
    refine le_trans (norm_tmul_sub_le (a : Hs.carrier) (a' : Hs.carrier) u u') ?_
    refine add_le_add (mul_le_mul_of_nonneg_right ha'₁.le hu0) ?_
    exact mul_le_mul ha'norm hb₁.le (norm_nonneg _) (by linarith)
  have hmove₂ : ‖(A a) ⊗ₜ[ℂ] u - (A a') ⊗ₜ[ℂ] u'‖ ≤ δ * ‖u‖ + (nAa + δ) * δ := by
    refine le_trans (norm_tmul_sub_le (A a) (A a') u u') ?_
    refine add_le_add (mul_le_mul_of_nonneg_right ha'₂.le hu0) ?_
    exact mul_le_mul hAa'norm hb₁.le (norm_nonneg _) (by linarith)
  have hmove₃ : ‖(a : Hs.carrier) ⊗ₜ[ℂ] w - (a' : Hs.carrier) ⊗ₜ[ℂ] w'‖
      ≤ δ * ‖w‖ + (na + δ) * δ := by
    refine le_trans (norm_tmul_sub_le (a : Hs.carrier) (a' : Hs.carrier) w w') ?_
    refine add_le_add (mul_le_mul_of_nonneg_right ha'₁.le hw0) ?_
    exact mul_le_mul ha'norm hb₂.le (norm_nonneg _) (by linarith)
  -- the two budgets
  have hbudget₁ : δ * ‖u‖ + (na + δ) * δ ≤ δ * C := by
    have hfac : δ * C - (δ * ‖u‖ + (na + δ) * δ) = δ * (nAa + ‖w‖ + 2 - δ) := by rw [hC]; ring
    have hnn : 0 ≤ δ * (nAa + ‖w‖ + 2 - δ) := mul_nonneg hδpos.le (by linarith)
    linarith
  have hbudget₂ :
      (δ * ‖u‖ + (nAa + δ) * δ) + (δ * ‖w‖ + (na + δ) * δ) ≤ δ * C := by
    have hfac : δ * C - ((δ * ‖u‖ + (nAa + δ) * δ) + (δ * ‖w‖ + (na + δ) * δ))
        = 2 * (δ * (1 - δ)) := by rw [hC]; ring
    have hnn : 0 ≤ 2 * (δ * (1 - δ)) := by
      have : 0 ≤ δ * (1 - δ) := mul_nonneg hδpos.le (by linarith)
      linarith
    linarith
  -- assemble the two components
  rw [Prod.dist_eq]
  refine max_lt ?_ ?_
  · rw [dist_eq_norm]
    have hcomp : (graphPow Hs D₂ A (n + 1) (a ⊗ₜ[ℂ] b)).1
        - (graphPow Hs D₂ A (n + 1) (a' ⊗ₜ[ℂ] b')).1
        = (a : Hs.carrier) ⊗ₜ[ℂ] u - (a' : Hs.carrier) ⊗ₜ[ℂ] u' := rfl
    rw [hcomp]
    exact lt_of_le_of_lt (le_trans hmove₁ hbudget₁) hδC
  · rw [dist_eq_norm]
    have hcomp : (graphPow Hs D₂ A (n + 1) (a ⊗ₜ[ℂ] b)).2
        - (graphPow Hs D₂ A (n + 1) (a' ⊗ₜ[ℂ] b')).2
        = ((A a) ⊗ₜ[ℂ] u - (A a') ⊗ₜ[ℂ] u')
          + ((a : Hs.carrier) ⊗ₜ[ℂ] w - (a' : Hs.carrier) ⊗ₜ[ℂ] w') := by
      change ((A a) ⊗ₜ[ℂ] u + (a : Hs.carrier) ⊗ₜ[ℂ] w)
          - ((A a') ⊗ₜ[ℂ] u' + (a' : Hs.carrier) ⊗ₜ[ℂ] w') = _
      abel
    rw [hcomp]
    refine lt_of_le_of_lt (norm_add_le _ _) ?_
    exact lt_of_le_of_lt (le_trans (add_le_add hmove₂ hmove₃) hbudget₂) hδC
