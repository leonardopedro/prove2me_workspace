-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.embedMatter_sub
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}
variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {N : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (m : ℕ) (M P : Matrix (Fin m) (Fin m) ℂ) :
    embedMatter m (M - P) = embedMatter m M - embedMatter m P := by

  ext i j
  simp only [embedMatter, Matrix.reindex_apply, Matrix.submatrix_apply, Matrix.sub_apply]
  rcases finSumFinEquiv.symm i with u | u <;> rcases finSumFinEquiv.symm j with v | v <;> simp
