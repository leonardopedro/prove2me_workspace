-- Generated from ChapterH8Bases.lean — theorem BookProof.ChapterH8.sirk_band_refinement_of_orthonormal
import Mathlib
import Definitions.Def_ChapterH8Bases
open BookProof.ChapterH8

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap

theorem BookProof.ChapterH8.sirk_band_refinement_of_orthonormal {m n : ℕ} (hmn : m ≤ n) (X : E →L[ℂ] E)
    (w : Fin m → E) (w' : Fin n → E) (hw : Orthonormal ℂ w) (hw' : Orthonormal ℂ w')
    (hnest : ∀ i : Fin m, w i = w' (Fin.castLE hmn i))
    (hinvm : ∀ x, ∃ y, X (orthonormalEmbedding w hw x) = orthonormalEmbedding w hw y)
    (hinvn : ∀ x, ∃ y, X (orthonormalEmbedding w' hw' x) = orthonormalEmbedding w' hw' y)
    (p : Polynomial ℂ) (v : E)
    (hv : orthonormalEmbedding w hw ((adjoint (orthonormalEmbedding w hw)) v) = v) :
    orthonormalEmbedding w' hw'
        ((Polynomial.aeval (compress (orthonormalEmbedding w' hw') X) p)
          ((adjoint (orthonormalEmbedding w' hw')) v))
      = orthonormalEmbedding w hw
        ((Polynomial.aeval (compress (orthonormalEmbedding w hw) X) p)
          ((adjoint (orthonormalEmbedding w hw)) v)) := by sorry
