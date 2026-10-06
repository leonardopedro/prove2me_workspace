-- Generated from ChapterSmOneParticle.lean — solution of BookProof.SmOneParticle.unitary_entry_norm_le_one
import Mathlib
import Definitions.Def_ChapterSmOneParticle
import Theorems.Thm_BookProof_SmOneParticle_unitary_row_sum_normSq
open BookProof.SmOneParticle

variable {V U : Matrix (Fin 3) (Fin 3) ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (hV : IsMixing V) (i j : Fin 3) : ‖V i j‖ ≤ 1 := by

  have hsum := unitary_row_sum_normSq hV i
  have hle : ‖V i j‖ ^ 2 ≤ ∑ k : Fin 3, ‖V i k‖ ^ 2 :=
    Finset.single_le_sum (f := fun k : Fin 3 => ‖V i k‖ ^ 2)
      (fun _ _ => by positivity) (Finset.mem_univ j)
  rw [hsum] at hle
  nlinarith [norm_nonneg (V i j)]
