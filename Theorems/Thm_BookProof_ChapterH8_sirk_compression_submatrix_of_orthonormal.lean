-- Generated from ChapterH8Bases.lean — theorem BookProof.ChapterH8.sirk_compression_submatrix_of_orthonormal
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterH5
import Mathlib
import Definitions.Def_ChapterH8Bases
import Definitions.Def_ChapterH6
import Definitions.Def_ChapterH8
open BookProof.ChapterH6
open BookProof.ChapterH8

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6




open ContinuousLinearMap

theorem BookProof.ChapterH8.sirk_compression_submatrix_of_orthonormal {m n : ℕ} (hmn : m ≤ n) (X : E →L[ℂ] E)
    (w : Fin m → E) (w' : Fin n → E) (hw : Orthonormal ℂ w) (hw' : Orthonormal ℂ w')
    (hnest : ∀ i : Fin m, w i = w' (Fin.castLE hmn i)) :
    reduceGenerator m (orthonormalEmbedding w hw) X
      = (reduceGenerator n (orthonormalEmbedding w' hw') X).submatrix
          (Fin.castLE hmn) (Fin.castLE hmn) := by sorry
