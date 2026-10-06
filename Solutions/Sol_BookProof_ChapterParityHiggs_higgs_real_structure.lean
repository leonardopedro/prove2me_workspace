-- Generated from ChapterParityHiggs.lean — solution of BookProof.ChapterParityHiggs.higgs_real_structure
import Mathlib
import Definitions.Def_ChapterParityHiggs
import Theorems.Thm_BookProof_ChapterParityHiggs_realityOp_realityOp
import Theorems.Thm_BookProof_ChapterParityHiggs_higgsReal_mul_conj
open BookProof.ChapterParityHiggs



open Matrix
open scoped Kronecker
open scoped ComplexConjugate


open BookProof.ChapterParity

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 2 × Fin 2 → ℂ) :
    realityOp higgsReal (realityOp higgsReal v) = v := by

  rw [realityOp_realityOp, higgsReal_mul_conj]
  ext i; simp [Matrix.mulVec, dotProduct, Matrix.one_apply]
