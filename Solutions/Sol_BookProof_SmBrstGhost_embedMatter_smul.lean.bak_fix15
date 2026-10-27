-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.embedMatter_smul
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}
variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {N : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (m : ℕ) (c : ℂ) (M : Matrix (Fin m) (Fin m) ℂ) :
    embedMatter m (c • M) = c • embedMatter m M := by

  ext i j
  simp only [embedMatter, Matrix.reindex_apply, Matrix.submatrix_apply, Matrix.smul_apply,
    smul_eq_mul]
  rcases finSumFinEquiv.symm i with u | u <;> rcases finSumFinEquiv.symm j with v | v <;> simp
