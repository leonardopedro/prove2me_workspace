-- Generated from ChapterTensorKatoRellich.lean — solution of BookProof.TensorKatoRellich.coupling_relBound
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
import Theorems.Thm_BookProof_TensorKatoRellich_norm_le_norm_sum_tmul_orthonormal
import Theorems.Thm_BookProof_TensorKatoRellich_norm_sum_tmul_le
import Theorems.Thm_BookProof_TensorKatoRellich_pairLiftOp_apply
import Theorems.Thm_BookProof_TensorKatoRellich_exists_pre
import Theorems.Thm_BookProof_TensorSumEsa_cpairOp_apply
open BookProof.TensorKatoRellich




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable {ι : Type*} [Fintype ι]

set_option maxHeartbeats 1000000 in
theorem solution [FiniteDimensional ℂ DB] (A : DA →ₗ[ℂ] Hs.carrier)
    (B : DB →ₗ[ℂ] Ks.carrier) (V : ι → DA →ₗ[ℂ] Hs.carrier) (Y : ι → DB →ₗ[ℂ] Ks.carrier)
    (hV : ∀ i, ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, ∀ u : DA,
      ‖V i u‖ ≤ ε * ‖A u‖ + C * ‖(u : Hs.carrier)‖) :
    ∃ a b : ℝ, 0 ≤ a ∧ a < 1 ∧ 0 ≤ b ∧ ∀ x : cpairDom Hs Ks DA DB,
      ‖pairLiftOp Hs Ks DA DB (couplingPoly Hs Ks DA DB V Y) x‖
        ≤ a * ‖cpairOp Hs Ks DA DB A B x‖ + b * ‖(x : ctensor Hs Ks)‖ := by

  classical
  set β := stdOrthonormalBasis ℂ DB with hβdef
  have hβK : Orthonormal ℂ (fun j => ((β j : DB) : Ks.carrier)) :=
    β.orthonormal.comp_linearIsometry DB.subtypeₗᵢ
  set MY : ℝ := ∑ i, ∑ j, ‖Y i (β j)‖ with hMY
  set MB : ℝ := ∑ j, ‖B (β j)‖ with hMB
  have hMY0 : 0 ≤ MY := Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => norm_nonneg _
  have hMB0 : 0 ≤ MB := Finset.sum_nonneg fun j _ => norm_nonneg _
  set ε : ℝ := 1 / (2 * (MY + 1)) with hε
  have hε0 : 0 < ε := by positivity
  choose C hC using fun i => hV i ε hε0
  set Cs : ℝ := ∑ i, |C i| with hCs
  have hCs0 : 0 ≤ Cs := Finset.sum_nonneg fun i _ => abs_nonneg _
  have hCi : ∀ i, |C i| ≤ Cs := fun i =>
    Finset.single_le_sum (f := fun i => |C i|) (fun i _ => abs_nonneg _) (Finset.mem_univ i)
  refine ⟨MY * ε, MY * ε * MB + MY * Cs, by positivity, ?_, by positivity, ?_⟩
  · rw [hε]
    rw [show MY * (1 / (2 * (MY + 1))) = MY / (2 * (MY + 1)) by ring,
      div_lt_one (by positivity)]
    linarith
  intro x
  obtain ⟨x₀, hx⟩ := exists_pre Hs Ks DA DB x
  obtain ⟨c, hc⟩ : ∃ c : Fin (Module.finrank ℂ DB) → DA, x₀ = ∑ j, c j ⊗ₜ[ℂ] β j := by
    refine ⟨fun j => TensorProduct.equivFinsuppOfBasisRight β.toBasis x₀ j, ?_⟩
    conv_lhs => rw [← (TensorProduct.equivFinsuppOfBasisRight β.toBasis).symm_apply_apply x₀]
    rw [TensorProduct.equivFinsuppOfBasisRight_symm_apply, Finsupp.sum_fintype]
    · simp [OrthonormalBasis.coe_toBasis]
    · intro i; simp
  have hincl : inclPair Hs Ks DA DB x₀
      = ∑ j, (c j : Hs.carrier) ⊗ₜ[ℂ] ((β j : DB) : Ks.carrier) := by
    change (inclPair Hs Ks DA DB).toLinearMap x₀ = _
    rw [hc, map_sum]; rfl
  have hsum : sumPoly Hs Ks DA DB A B x₀
      = ∑ j, A (c j) ⊗ₜ[ℂ] ((β j : DB) : Ks.carrier)
        + ∑ j, (c j : Hs.carrier) ⊗ₜ[ℂ] B (β j) := by
    rw [hc, map_sum, ← Finset.sum_add_distrib]; rfl
  have hcoup : couplingPoly Hs Ks DA DB V Y x₀
      = ∑ i, ∑ j, V i (c j) ⊗ₜ[ℂ] Y i (β j) := by
    rw [hc, couplingPoly, LinearMap.sum_apply]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [map_sum]; rfl
  have hnx : ‖(x : ctensor Hs Ks)‖ = ‖inclPair Hs Ks DA DB x₀‖ := by
    rw [hx, LinearIsometry.norm_map]
  have hnH : ‖cpairOp Hs Ks DA DB A B x‖ = ‖sumPoly Hs Ks DA DB A B x₀‖ := by
    rw [cpairOp_apply Hs Ks DA DB A B x x₀ hx, LinearIsometry.norm_map]
  have hnB : ‖pairLiftOp Hs Ks DA DB (couplingPoly Hs Ks DA DB V Y) x‖
      = ‖couplingPoly Hs Ks DA DB V Y x₀‖ := by
    rw [pairLiftOp_apply Hs Ks DA DB _ x x₀ hx, LinearIsometry.norm_map]
  rw [hnx, hnH, hnB, hincl, hsum, hcoup]
  set S := ‖∑ j, (c j : Hs.carrier) ⊗ₜ[ℂ] ((β j : DB) : Ks.carrier)‖ with hS
  set Sh := ‖∑ j, A (c j) ⊗ₜ[ℂ] ((β j : DB) : Ks.carrier)‖ with hSh
  set T := ‖∑ j, A (c j) ⊗ₜ[ℂ] ((β j : DB) : Ks.carrier)
      + ∑ j, (c j : Hs.carrier) ⊗ₜ[ℂ] B (β j)‖ with hT
  have hcj : ∀ j, ‖(c j : Hs.carrier)‖ ≤ S := fun j =>
    norm_le_norm_sum_tmul_orthonormal hβK (fun j => (c j : Hs.carrier)) j
  have hAcj : ∀ j, ‖A (c j)‖ ≤ Sh := fun j =>
    norm_le_norm_sum_tmul_orthonormal hβK (fun j => A (c j)) j
  have hS0 : 0 ≤ S := norm_nonneg _
  have hSh0 : 0 ≤ Sh := norm_nonneg _
  have hShT : Sh ≤ T + S * MB := by
    have h1 : Sh ≤ T + ‖∑ j, (c j : Hs.carrier) ⊗ₜ[ℂ] B (β j)‖ := by
      rw [hSh, hT]
      have := norm_sub_le (∑ j, A (c j) ⊗ₜ[ℂ] ((β j : DB) : Ks.carrier)
        + ∑ j, (c j : Hs.carrier) ⊗ₜ[ℂ] B (β j)) (∑ j, (c j : Hs.carrier) ⊗ₜ[ℂ] B (β j))
      simpa using this
    have h2 : ‖∑ j, (c j : Hs.carrier) ⊗ₜ[ℂ] B (β j)‖ ≤ S * MB := by
      refine (norm_sum_tmul_le _ _).trans ?_
      rw [hMB, Finset.mul_sum]
      exact Finset.sum_le_sum fun j _ => mul_le_mul_of_nonneg_right (hcj j) (norm_nonneg _)
    linarith
  have hVc : ∀ i j, ‖V i (c j)‖ ≤ ε * Sh + Cs * S := by
    intro i j
    refine (hC i (c j)).trans ?_
    have h1 : C i * ‖(c j : Hs.carrier)‖ ≤ Cs * S :=
      (mul_le_mul_of_nonneg_right (le_abs_self _) (norm_nonneg _)).trans
        (mul_le_mul (hCi i) (hcj j) (norm_nonneg _) hCs0)
    have h2 : ε * ‖A (c j)‖ ≤ ε * Sh := mul_le_mul_of_nonneg_left (hAcj j) hε0.le
    linarith
  have hcoupB : ‖∑ i, ∑ j, V i (c j) ⊗ₜ[ℂ] Y i (β j)‖ ≤ (ε * Sh + Cs * S) * MY := by
    refine (norm_sum_le _ _).trans ?_
    rw [hMY, Finset.mul_sum]
    refine Finset.sum_le_sum fun i _ => ?_
    refine (norm_sum_tmul_le _ _).trans ?_
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun j _ => mul_le_mul_of_nonneg_right (hVc i j) (norm_nonneg _)
  calc ‖∑ i, ∑ j, V i (c j) ⊗ₜ[ℂ] Y i (β j)‖ ≤ (ε * Sh + Cs * S) * MY := hcoupB
    _ ≤ (ε * (T + S * MB) + Cs * S) * MY := by
        gcongr
    _ = MY * ε * T + (MY * ε * MB + MY * Cs) * S := by ring
