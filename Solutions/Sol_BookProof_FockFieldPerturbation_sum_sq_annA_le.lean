-- Generated from ChapterFockFieldPerturbation.lean — solution of BookProof.FockFieldPerturbation.sum_sq_annA_le
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
import Theorems.Thm_BookProof_FockFieldPerturbation_numberQuad_eq_sum
open BookProof.FockFieldPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

set_option maxHeartbeats 1000000 in
theorem solution (u : FockAlg) (S : Finset ℕ) :
    ∑ k ∈ S, ‖toLp (annA k u)‖ ^ 2 ≤ numberQuad u := by

  classical
  rw [numberQuad_eq_sum (K := S ∪ modes u) Finset.subset_union_right]
  exact Finset.sum_le_sum_of_subset_of_nonneg Finset.subset_union_left
    fun _ _ _ => sq_nonneg _
