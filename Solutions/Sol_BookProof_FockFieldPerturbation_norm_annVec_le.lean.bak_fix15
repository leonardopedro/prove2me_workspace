-- Generated from ChapterFockFieldPerturbation.lean — solution of BookProof.FockFieldPerturbation.norm_annVec_le
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
import Theorems.Thm_BookProof_FockFieldPerturbation_annVec_apply
import Theorems.Thm_BookProof_FockFieldPerturbation_l2norm_nonneg
import Theorems.Thm_BookProof_FockFieldPerturbation_sum_sq_annA_le
import Theorems.Thm_BookProof_FockSecondQuantization_toLpL_apply
open BookProof.FockFieldPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

set_option maxHeartbeats 1000000 in
theorem solution (f : ℕ →₀ ℂ) (u : FockAlg) :
    ‖toLp (annVec f u)‖ ≤ l2norm f * Real.sqrt (numberQuad u) := by

  classical
  have hexp : toLp (annVec f u)
      = ∑ j ∈ f.support, ((starRingEnd ℂ) (f j)) • toLp (annA j u) := by
    rw [annVec_apply, ← toLpL_apply, map_sum]
    exact Finset.sum_congr rfl fun j _ => by rw [map_smul, toLpL_apply]
  rw [hexp]
  calc ‖∑ j ∈ f.support, ((starRingEnd ℂ) (f j)) • toLp (annA j u)‖
      ≤ ∑ j ∈ f.support, ‖((starRingEnd ℂ) (f j)) • toLp (annA j u)‖ := norm_sum_le _ _
    _ = ∑ j ∈ f.support, ‖f j‖ * ‖toLp (annA j u)‖ := by
        refine Finset.sum_congr rfl fun j _ => ?_
        rw [norm_smul]
        simp
    _ ≤ Real.sqrt (∑ j ∈ f.support, ‖f j‖ ^ 2)
          * Real.sqrt (∑ j ∈ f.support, ‖toLp (annA j u)‖ ^ 2) :=
        Real.sum_mul_le_sqrt_mul_sqrt _ _ _
    _ ≤ l2norm f * Real.sqrt (numberQuad u) :=
        mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt (sum_sq_annA_le u f.support))
          (l2norm_nonneg f)
