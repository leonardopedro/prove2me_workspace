-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.embedMatter_col_ghost
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}
variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {N : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (m : ℕ) (M : Matrix (Fin m) (Fin m) ℂ) (b : Fin 12)
    (i : Fin (m + 12)) : embedMatter m M i (ghostMode m b) = 0 := by

  rcases h : finSumFinEquiv.symm i with u | u <;>
    simp [embedMatter, ghostMode, Matrix.reindex_apply, Matrix.submatrix_apply, h]
