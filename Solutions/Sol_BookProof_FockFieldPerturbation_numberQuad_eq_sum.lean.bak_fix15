-- Generated from ChapterFockFieldPerturbation.lean — solution of BookProof.FockFieldPerturbation.numberQuad_eq_sum
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
import Theorems.Thm_BookProof_FockFieldPerturbation_creVec_numberCol
import Theorems.Thm_BookProof_FockSecondQuantization_dGamma_eq_sum
import Theorems.Thm_BookProof_FockSecondQuantization_inner_creA_right
import Theorems.Thm_BookProof_FockSecondQuantization_toLpL_apply
open BookProof.FockFieldPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

set_option maxHeartbeats 1000000 in
theorem solution {u : FockAlg} {K : Finset ℕ} (hK : modes u ⊆ K) :
    numberQuad u = ∑ k ∈ K, ‖toLp (annA k u)‖ ^ 2 := by

  have hsum : dGamma numberCol u = ∑ k ∈ K, creA k (annA k u) := by
    rw [dGamma_eq_sum numberCol hK]
    exact Finset.sum_congr rfl fun k _ => creVec_numberCol k _
  have htoLp : toLp (∑ k ∈ K, creA k (annA k u)) = ∑ k ∈ K, toLp (creA k (annA k u)) := by
    rw [← toLpL_apply, map_sum]
    rfl
  rw [numberQuad, hsum, htoLp, inner_sum, Complex.re_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [inner_creA_right, inner_self_eq_norm_sq_to_K]
  norm_cast
