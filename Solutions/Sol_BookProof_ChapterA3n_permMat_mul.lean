-- Generated from ChapterA3n.lean — solution of BookProof.ChapterA3n.permMat_mul
import Mathlib
import Definitions.Def_ChapterA3n
open BookProof.ChapterA3n



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (σ τ : Equiv.Perm (Fin N)) :
    permMat σ * permMat τ = permMat (σ * τ) := by

  ext a c; simp only [mul_apply] ;
  unfold permMat; simp [ Finset.sum_ite ] ;
  rfl
