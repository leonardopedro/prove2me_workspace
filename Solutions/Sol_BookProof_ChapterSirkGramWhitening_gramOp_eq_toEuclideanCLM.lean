-- Generated from ChapterSirkGramWhitening.lean — solution of BookProof.ChapterSirkGramWhitening.gramOp_eq_toEuclideanCLM
import Mathlib
import Definitions.Def_ChapterSirkGramWhitening
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_gramOp_apply
open BookProof.ChapterSirkGramWhitening



noncomputable section


open scoped InnerProductSpace
open Matrix
open BookProof.ChapterH4 BookProof.ChapterSirkWhitening

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
ix, Matrix.conjTranspose_apply]

theorem solution {m : ℕ} (w : Fin m → E) :
    gramOp w = Matrix.toEuclidean :=
  CLM (𝕜 := ℂ) (gramMatrix w) := by
    ext c i
    simpa [gramMatrix, Matrix.ofLp_toEuclideanCLM, Matrix.mulVec, dotProd
