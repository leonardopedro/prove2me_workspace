-- Generated from ChapterSchurGershgorinGap.lean — solution of BookProof.SchurGershgorin.quadForm_ge_of_gershgorin_on
import Mathlib
import Definitions.Def_ChapterSchurGershgorinGap
import Theorems.Thm_BookProof_SchurGershgorin_exists_repr_of_mem_span_image
import Theorems.Thm_BookProof_SchurGershgorin_norm_sq_sum
import Theorems.Thm_BookProof_SchurGershgorin_quadForm_sum_ge
open BookProof.SchurGershgorin



noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.TruncationGapLift
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F)
    (H : finiteModeDomain b →ₗ[ℂ] F) (hsym : SymmetricOn _ H) (T : Set ℕ) {mu : ℝ}
    (d r : ℕ → ℝ)
    (hdiag : ∀ i ∈ T, d i ≤ (entry b H i i).re)
    (hrow : ∀ i ∈ T, ∀ S : Finset ℕ, (↑S : Set ℕ) ⊆ T → i ∉ S →
      ∑ j ∈ S, ‖entry b H i j‖ ≤ r i)
    (hgap : ∀ i ∈ T, mu ≤ d i - r i)
    (v : finiteModeDomain b) (hv : (v : F) ∈ Submodule.span ℂ (b '' T)) :
    mu * ‖(v : F)‖ ^ 2 ≤ quadForm H v := by

  classical
  obtain ⟨S, c, hST, hvc⟩ := exists_repr_of_mem_span_image b T hv
  have hvsum : v = ∑ i ∈ S, c i • bvec b i := by
    refine Subtype.ext ?_
    rw [hvc]
    push_cast
    rfl
  have hdiagS : ∀ i ∈ S, d i ≤ (entry b H i i).re := fun i hi => hdiag i (hST hi)
  have hrowS : ∀ i ∈ S, ∑ j ∈ S.erase i, ‖entry b H i j‖ ≤ r i := by
    intro i hi
    refine hrow i (hST hi) (S.erase i) ?_ ?_
    · intro j hj
      have hj' : j ∈ S.erase i := Finset.mem_coe.mp hj
      exact hST (Finset.mem_coe.mpr (Finset.mem_of_mem_erase hj'))
    · simp
  have hmain := quadForm_sum_ge b H hsym S c d r hdiagS hrowS
  have hnorm : ‖(v : F)‖ ^ 2 = ∑ i ∈ S, ‖c i‖ ^ 2 := by
    rw [hvc]; exact norm_sq_sum b S c
  have hle : mu * ‖(v : F)‖ ^ 2 ≤ ∑ i ∈ S, (d i - r i) * ‖c i‖ ^ 2 := by
    rw [hnorm, Finset.mul_sum]
    refine Finset.sum_le_sum fun i hi => ?_
    exact mul_le_mul_of_nonneg_right (hgap i (hST hi)) (sq_nonneg _)
  calc mu * ‖(v : F)‖ ^ 2 ≤ ∑ i ∈ S, (d i - r i) * ‖c i‖ ^ 2 := hle
    _ ≤ quadForm H (∑ i ∈ S, c i • bvec b i) := hmain
    _ = quadForm H v := by rw [← hvsum]
