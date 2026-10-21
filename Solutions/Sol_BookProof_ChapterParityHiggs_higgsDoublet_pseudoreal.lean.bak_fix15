-- Generated from ChapterParityHiggs.lean — solution of BookProof.ChapterParityHiggs.higgsDoublet_pseudoreal
import Mathlib
import Definitions.Def_ChapterParityHiggs
import Theorems.Thm_BookProof_ChapterParityHiggs_realityOp_realityOp
import Theorems.Thm_BookProof_ChapterParityHiggs_pauli2_pseudoreal
open BookProof.ChapterParityHiggs



open Matrix
open scoped Kronecker
open scoped ComplexConjugate


open BookProof.ChapterParity

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 2 → ℂ) :
    realityOp pauli2 (realityOp pauli2 v) = -v := by

  rw [realityOp_realityOp, pauli2_pseudoreal]
  ext i; simp [Matrix.mulVec, dotProduct, Matrix.one_apply]
