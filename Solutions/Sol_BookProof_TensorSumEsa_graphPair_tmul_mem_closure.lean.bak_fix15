-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.graphPair_tmul_mem_closure
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Theorems.Thm_BookProof_TensorSumEsa_tmul_mem_pairCorePoly
import Theorems.Thm_BookProof_TensorCore_norm_tmul_sub_le
open BookProof.TensorSumEsa




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable {Hs Ks : IPSpace} {DA : Submodule ℂ Hs.carrier} {DB : Submodule ℂ Ks.carrier}
  {A : DA →ₗ[ℂ] Hs.carrier} {B : DB →ₗ[ℂ] Ks.carrier}
variable (P : OneParticleFlow Hs DA A) (Q : OneParticleFlow Ks DB B)
variable {Hs Ks : IPSpace} [CompleteSpace Hs.carrier] [CompleteSpace Ks.carrier]
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
  (CA : Submodule ℂ Hs.carrier) (CB : Submodule ℂ Ks.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (hcoreA : IsGraphCore CA A) (hcoreB : IsGraphCore CB B)
    (a : DA) (b : DB) :
    graphPair Hs Ks DA DB A B (a ⊗ₜ[ℂ] b) ∈
      (Submodule.map (graphPair Hs Ks DA DB A B)
        (pairCorePoly Hs Ks DA DB CA CB)).topologicalClosure := by

  change graphPair Hs Ks DA DB A B (a ⊗ₜ[ℂ] b) ∈
    closure ((Submodule.map (graphPair Hs Ks DA DB A B)
      (pairCorePoly Hs Ks DA DB CA CB)) : Set _)
  refine Metric.mem_closure_iff.mpr ?_
  intro ε hε
  set na : ℝ := ‖(a : Hs.carrier)‖ with hna
  set nAa : ℝ := ‖A a‖ with hnAa
  set nb : ℝ := ‖(b : Ks.carrier)‖ with hnb
  set nBb : ℝ := ‖B b‖ with hnBb
  set C : ℝ := na + nAa + nb + nBb + 4 with hC
  have hna0 : 0 ≤ na := norm_nonneg _
  have hnAa0 : 0 ≤ nAa := norm_nonneg _
  have hnb0 : 0 ≤ nb := norm_nonneg _
  have hnBb0 : 0 ≤ nBb := norm_nonneg _
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
  obtain ⟨a', ha'C, ha'₁, ha'₂⟩ := hcoreA a δ hδpos
  obtain ⟨b', hb'C, hb'₁, hb'₂⟩ := hcoreB b δ hδpos
  have ha'norm : ‖(a' : Hs.carrier)‖ ≤ na + δ := by
    have h1 := norm_sub_norm_le (a' : Hs.carrier) (a : Hs.carrier)
    have h2 : ‖(a' : Hs.carrier) - (a : Hs.carrier)‖ < δ := by rw [norm_sub_rev]; exact ha'₁
    rw [hna]; linarith
  have hAa'norm : ‖A a'‖ ≤ nAa + δ := by
    have h1 := norm_sub_norm_le (A a') (A a)
    have h2 : ‖A a' - A a‖ < δ := by rw [norm_sub_rev]; exact ha'₂
    rw [hnAa]; linarith
  refine ⟨graphPair Hs Ks DA DB A B (a' ⊗ₜ[ℂ] b'),
    ⟨a' ⊗ₜ[ℂ] b', tmul_mem_pairCorePoly Hs Ks DA DB CA CB ha'C hb'C, rfl⟩, ?_⟩
  have hmove₁ : ‖(a : Hs.carrier) ⊗ₜ[ℂ] (b : Ks.carrier)
        - (a' : Hs.carrier) ⊗ₜ[ℂ] (b' : Ks.carrier)‖ ≤ δ * nb + (na + δ) * δ := by
    refine le_trans (TensorCore.norm_tmul_sub_le (a : Hs.carrier) (a' : Hs.carrier)
      (b : Ks.carrier) (b' : Ks.carrier)) ?_
    refine add_le_add (mul_le_mul_of_nonneg_right ha'₁.le hnb0) ?_
    exact mul_le_mul ha'norm hb'₁.le (norm_nonneg _) (by linarith)
  have hmove₂ : ‖(A a) ⊗ₜ[ℂ] (b : Ks.carrier) - (A a') ⊗ₜ[ℂ] (b' : Ks.carrier)‖
      ≤ δ * nb + (nAa + δ) * δ := by
    refine le_trans (TensorCore.norm_tmul_sub_le (A a) (A a') (b : Ks.carrier)
      (b' : Ks.carrier)) ?_
    refine add_le_add (mul_le_mul_of_nonneg_right ha'₂.le hnb0) ?_
    exact mul_le_mul hAa'norm hb'₁.le (norm_nonneg _) (by linarith)
  have hmove₃ : ‖(a : Hs.carrier) ⊗ₜ[ℂ] (B b) - (a' : Hs.carrier) ⊗ₜ[ℂ] (B b')‖
      ≤ δ * nBb + (na + δ) * δ := by
    refine le_trans (TensorCore.norm_tmul_sub_le (a : Hs.carrier) (a' : Hs.carrier) (B b)
      (B b')) ?_
    refine add_le_add (mul_le_mul_of_nonneg_right ha'₁.le hnBb0) ?_
    exact mul_le_mul ha'norm hb'₂.le (norm_nonneg _) (by linarith)
  have hbudget₁ : δ * nb + (na + δ) * δ ≤ δ * C := by
    have hfac : δ * C - (δ * nb + (na + δ) * δ) = δ * (nAa + nBb + 4 - δ) := by rw [hC]; ring
    have hnn : 0 ≤ δ * (nAa + nBb + 4 - δ) := mul_nonneg hδpos.le (by linarith)
    linarith
  have hbudget₂ : (δ * nb + (nAa + δ) * δ) + (δ * nBb + (na + δ) * δ) ≤ δ * C := by
    have hfac : δ * C - ((δ * nb + (nAa + δ) * δ) + (δ * nBb + (na + δ) * δ))
        = 2 * (δ * (2 - δ)) := by rw [hC]; ring
    have hnn : 0 ≤ 2 * (δ * (2 - δ)) := by
      have : 0 ≤ δ * (2 - δ) := mul_nonneg hδpos.le (by linarith)
      linarith
    linarith
  rw [Prod.dist_eq]
  refine max_lt ?_ ?_
  · rw [dist_eq_norm]
    have hcomp : (graphPair Hs Ks DA DB A B (a ⊗ₜ[ℂ] b)).1
        - (graphPair Hs Ks DA DB A B (a' ⊗ₜ[ℂ] b')).1
        = (a : Hs.carrier) ⊗ₜ[ℂ] (b : Ks.carrier)
          - (a' : Hs.carrier) ⊗ₜ[ℂ] (b' : Ks.carrier) := rfl
    rw [hcomp]
    linarith
  · rw [dist_eq_norm]
    have hcomp : (graphPair Hs Ks DA DB A B (a ⊗ₜ[ℂ] b)).2
        - (graphPair Hs Ks DA DB A B (a' ⊗ₜ[ℂ] b')).2
        = ((A a) ⊗ₜ[ℂ] (b : Ks.carrier) - (A a') ⊗ₜ[ℂ] (b' : Ks.carrier))
          + ((a : Hs.carrier) ⊗ₜ[ℂ] (B b) - (a' : Hs.carrier) ⊗ₜ[ℂ] (B b')) := by
      change ((A a) ⊗ₜ[ℂ] (b : Ks.carrier) + (a : Hs.carrier) ⊗ₜ[ℂ] (B b))
          - ((A a') ⊗ₜ[ℂ] (b' : Ks.carrier) + (a' : Hs.carrier) ⊗ₜ[ℂ] (B b')) = _
      abel
    rw [hcomp]
    refine lt_of_le_of_lt (norm_add_le _ _) ?_
    linarith
