-- Generated from ChapterFockFieldPerturbation.lean — solution of BookProof.FockFieldPerturbation.inner_creVec_annVec
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
import Theorems.Thm_BookProof_FockFieldPerturbation_annVec_apply
import Theorems.Thm_BookProof_FockSecondQuantization_creVec_apply
import Theorems.Thm_BookProof_FockSecondQuantization_inner_creA_right
import Theorems.Thm_BookProof_FockSecondQuantization_toLpL_apply
open BookProof.FockFieldPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

set_option maxHeartbeats 1000000 in
theorem solution (f : ℕ →₀ ℂ) (u v : FockAlg) :
    (inner ℂ (toLp u) (toLp (creVec f v)) : ℂ) = inner ℂ (toLp (annVec f u)) (toLp v) := by

  classical
  have hc : toLp (creVec f v) = ∑ j ∈ f.support, (f j) • toLp (creA j v) := by
    rw [creVec_apply, ← toLpL_apply, map_sum]
    exact Finset.sum_congr rfl fun j _ => by rw [map_smul, toLpL_apply]
  have ha : toLp (annVec f u)
      = ∑ j ∈ f.support, ((starRingEnd ℂ) (f j)) • toLp (annA j u) := by
    rw [annVec_apply, ← toLpL_apply, map_sum]
    exact Finset.sum_congr rfl fun j _ => by rw [map_smul, toLpL_apply]
  rw [hc, ha, inner_sum, sum_inner]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [inner_smul_right, inner_smul_left, inner_creA_right]
  simp
