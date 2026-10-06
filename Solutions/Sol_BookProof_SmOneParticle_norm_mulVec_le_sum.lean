-- Generated from ChapterSmOneParticle.lean — solution of BookProof.SmOneParticle.norm_mulVec_le_sum
import Mathlib
import Definitions.Def_ChapterSmOneParticle
import Theorems.Thm_BookProof_SmOneParticle_unitary_entry_norm_le_one
open BookProof.SmOneParticle

variable {V U : Matrix (Fin 3) (Fin 3) ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (hV : IsMixing V) (b : Fin 3 → ℂ) (i : Fin 3) :
    ‖(V *ᵥ b) i‖ ≤ ∑ j : Fin 3, ‖b j‖ := by

  simp only [Matrix.mulVec, dotProduct]
  refine le_trans (norm_sum_le _ _) (Finset.sum_le_sum fun j _ => ?_)
  rw [norm_mul]
  exact mul_le_of_le_one_left (norm_nonneg _) (unitary_entry_norm_le_one hV i j)
