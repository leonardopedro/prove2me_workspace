-- Generated from ChapterSchurGershgorinGap.lean — solution of BookProof.SchurGershgorin.quadForm_sum_ge
import Mathlib
import Definitions.Def_ChapterSchurGershgorinGap
import Theorems.Thm_BookProof_SchurGershgorin_norm_entry_symm
import Theorems.Thm_BookProof_SchurGershgorin_quadForm_sum
import Theorems.Thm_BookProof_SchurGershgorin_sum_off_diag_comm
open BookProof.SchurGershgorin



noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.TruncationGapLift
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) (H : finiteModeDomain b →ₗ[ℂ] F)
    (hsym : SymmetricOn _ H) (S : Finset ℕ) (c : ℕ → ℂ) (d r : ℕ → ℝ)
    (hdiag : ∀ i ∈ S, d i ≤ (entry b H i i).re)
    (hrow : ∀ i ∈ S, ∑ j ∈ S.erase i, ‖entry b H i j‖ ≤ r i) :
    ∑ i ∈ S, (d i - r i) * ‖c i‖ ^ 2 ≤ quadForm H (∑ i ∈ S, c i • bvec b i) := by

  classical
  set N : ℕ → ℝ := fun i => ‖c i‖ ^ 2 with hN
  set A : ℕ → ℕ → ℝ := fun i j => ‖entry b H i j‖ with hA
  have hNnonneg : ∀ i, 0 ≤ N i := fun i => sq_nonneg _
  have hAnonneg : ∀ i j, 0 ≤ A i j := fun i j => norm_nonneg _
  set f : ℕ → ℕ → ℝ := fun i j => ((starRingEnd ℂ) (c i) * c j * entry b H i j).re with hf
  have hre : quadForm H (∑ i ∈ S, c i • bvec b i) = ∑ i ∈ S, ∑ j ∈ S, f i j := by
    rw [quadForm_sum]
    simp [Complex.re_sum, hf]
  have hdiagval : ∀ i, f i i = N i * (entry b H i i).re := by
    intro i
    have hz : (starRingEnd ℂ) (c i) * c i = ((N i : ℝ) : ℂ) := by
      rw [← Complex.normSq_eq_conj_mul_self, Complex.normSq_eq_norm_sq]
    simp only [hf]
    rw [hz, Complex.re_ofReal_mul]
  have hoff : ∀ i j, -(A i j * (N i + N j) / 2) ≤ f i j := by
    intro i j
    have h1 : |f i j| ≤ ‖(starRingEnd ℂ) (c i) * c j * entry b H i j‖ :=
      Complex.abs_re_le_norm _
    have h2 : ‖(starRingEnd ℂ) (c i) * c j * entry b H i j‖ = ‖c i‖ * ‖c j‖ * A i j := by
      simp [hA]
    rw [h2] at h1
    have h3 : -(‖c i‖ * ‖c j‖ * A i j) ≤ f i j := by linarith [(abs_le.mp h1).1]
    have h4 : 2 * (‖c i‖ * ‖c j‖) ≤ N i + N j := by
      have := sq_nonneg (‖c i‖ - ‖c j‖)
      simp only [hN]
      nlinarith
    nlinarith [hAnonneg i j]
  have hrowlb : ∀ i ∈ S, N i * d i - (∑ j ∈ S.erase i, A i j * (N i + N j) / 2)
      ≤ ∑ j ∈ S, f i j := by
    intro i hi
    have hsplit : ∑ j ∈ S, f i j = f i i + ∑ j ∈ S.erase i, f i j := by
      rw [← Finset.sum_erase_add S _ hi]; ring
    have h1 : N i * d i ≤ f i i := by
      rw [hdiagval i]
      exact mul_le_mul_of_nonneg_left (hdiag i hi) (hNnonneg i)
    have h2 : -(∑ j ∈ S.erase i, A i j * (N i + N j) / 2) ≤ ∑ j ∈ S.erase i, f i j := by
      rw [← Finset.sum_neg_distrib]
      exact Finset.sum_le_sum fun j _ => hoff i j
    rw [hsplit]; linarith
  have hsum1 : ∑ i ∈ S, (N i * d i - (∑ j ∈ S.erase i, A i j * (N i + N j) / 2))
      ≤ ∑ i ∈ S, ∑ j ∈ S, f i j := Finset.sum_le_sum hrowlb
  have hexp : ∀ i, (∑ j ∈ S.erase i, A i j * (N i + N j) / 2)
      = (∑ j ∈ S.erase i, A i j * N i) / 2 + (∑ j ∈ S.erase i, A i j * N j) / 2 := by
    intro i
    have hterm : ∀ j, A i j * (N i + N j) / 2 = A i j * N i / 2 + A i j * N j / 2 :=
      fun j => by ring
    simp_rw [hterm]
    rw [Finset.sum_add_distrib, ← Finset.sum_div, ← Finset.sum_div]
  have hT2 : ∑ i ∈ S, (∑ j ∈ S.erase i, A i j * N i) ≤ ∑ i ∈ S, r i * N i := by
    refine Finset.sum_le_sum fun i hi => ?_
    rw [← Finset.sum_mul]
    exact mul_le_mul_of_nonneg_right (hrow i hi) (hNnonneg i)
  have hT3 : ∑ i ∈ S, (∑ j ∈ S.erase i, A i j * N j) ≤ ∑ i ∈ S, r i * N i := by
    rw [sum_off_diag_comm S (fun i j => A i j * N j)]
    refine Finset.sum_le_sum fun j hj => ?_
    have hswap : ∀ i, A i j = A j i := fun i => norm_entry_symm b H hsym i j
    calc ∑ i ∈ S.erase j, A i j * N j = (∑ i ∈ S.erase j, A j i) * N j := by
            rw [Finset.sum_mul]
            exact Finset.sum_congr rfl fun i _ => by rw [hswap i]
      _ ≤ r j * N j := mul_le_mul_of_nonneg_right (hrow j hj) (hNnonneg j)
  rw [hre]
  have hlhs : ∑ i ∈ S, (d i - r i) * ‖c i‖ ^ 2 = ∑ i ∈ S, N i * d i - ∑ i ∈ S, r i * N i := by
    rw [← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun i _ => by simp only [hN]; ring
  have hrhs : ∑ i ∈ S, (N i * d i - (∑ j ∈ S.erase i, A i j * (N i + N j) / 2))
      = ∑ i ∈ S, N i * d i
        - ((∑ i ∈ S, (∑ j ∈ S.erase i, A i j * N i)) / 2
           + (∑ i ∈ S, (∑ j ∈ S.erase i, A i j * N j)) / 2) := by
    rw [Finset.sum_sub_distrib]
    congr 1
    rw [Finset.sum_div, Finset.sum_div, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun i _ => hexp i
  rw [hlhs]
  rw [hrhs] at hsum1
  linarith
