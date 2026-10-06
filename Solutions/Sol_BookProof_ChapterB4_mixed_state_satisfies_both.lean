-- Generated from ChapterB4.lean — solution of BookProof.ChapterB4.mixed_state_satisfies_both
import Mathlib
import Definitions.Def_ChapterB4
open BookProof.ChapterB4




open Matrix

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    Matrix.trace (((1 / 2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)) * P1) = 1 / 2 ∧
    Matrix.trace (((1 / 2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)) * P2) = 1 / 2 := by

  refine ⟨?_, ?_⟩ <;>
    norm_num [P1, P2, Matrix.trace_fin_two, Matrix.mul_apply, Fin.sum_univ_two,
      Matrix.one_apply]
