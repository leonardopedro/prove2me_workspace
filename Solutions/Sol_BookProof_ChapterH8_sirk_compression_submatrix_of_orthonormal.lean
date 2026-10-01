-- Generated from ChapterH8Bases.lean — solution of BookProof.ChapterH8.sirk_compression_submatrix_of_orthonormal
import Mathlib
import Definitions.Def_ChapterH8Bases
import Theorems.Thm_BookProof_ChapterH8_orthonormalEmbedding_single
import Theorems.Thm_BookProof_ChapterH8_sirk_compression_submatrix_le
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap

set_option maxHeartbeats 1000000 in
theorem solution {m n : ℕ} (hmn : m ≤ n) (X : E →L[ℂ] E)
    (w : Fin m → E) (w' : Fin n → E) (hw : Orthonormal ℂ w) (hw' : Orthonormal ℂ w')
    (hnest : ∀ i : Fin m, w i = w' (Fin.castLE hmn i)) :
    reduceGenerator m (orthonormalEmbedding w hw) X
      = (reduceGenerator n (orthonormalEmbedding w' hw') X).submatrix
          (Fin.castLE hmn) (Fin.castLE hmn) :=
  sirk_compression_submatrix_le hmn X _ _ fun i => by
      rw [orthonormalEmbedding_single, orthonormalEmbedding_single, hnest]
