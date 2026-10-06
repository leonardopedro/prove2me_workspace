-- Generated from ChapterSmOneParticle.lean — solution of BookProof.SmOneParticle.yukawa_bound
import Mathlib
import Definitions.Def_ChapterSmOneParticle
import Theorems.Thm_BookProof_SmOneParticle_norm_mulVec_le_sum
open BookProof.SmOneParticle

variable {V U : Matrix (Fin 3) (Fin 3) ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (hV : IsMixing V) (a b : Fin 3 → ℂ) :
    ‖∑ i : Fin 3, (starRingEnd ℂ) (a i) * (V *ᵥ b) i‖
      ≤ (∑ i : Fin 3, ‖a i‖) * ∑ j : Fin 3, ‖b j‖ := by

  refine le_trans (norm_sum_le _ _) ?_
  rw [Finset.sum_mul]
  refine Finset.sum_le_sum fun i _ => ?_
  rw [norm_mul, RCLike.norm_conj]
  exact mul_le_mul_of_nonneg_left (norm_mulVec_le_sum hV b i) (norm_nonneg _)
