-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.embedMatter_mul
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
    embedMatter m M * embedMatter m P = embedMatter m (M * P) := by

  simp only [embedMatter, Matrix.reindex_apply]
  rw [Matrix.submatrix_mul_equiv (Matrix.fromBlocks M 0 0 0) (Matrix.fromBlocks P 0 0 0)
    finSumFinEquiv.symm finSumFinEquiv.symm finSumFinEquiv.symm]
  congr 1
  rw [Matrix.fromBlocks_multiply]
  simp
