-- Generated from ChapterH9.lean — theorem BookProof.ChapterH9.sirk_numRange_krylov
import Mathlib
import Definitions.Def_ChapterH9
import Definitions.Def_BookProof.ChapterH9

open BookProof.ChapterH9


noncomputable section


open BookProof.ChapterH1 BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6
open BookProof.ChapterH8
open ContinuousLinearMap


variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

theorem BookProof.ChapterH9.sirk_numRange_krylov {m n : ℕ} (hmn : m ≤ n) (H : E →ₗ[ℂ] E) (v : E)
    (X : E →L[ℂ] E) (hli : LinearIndependent ℂ (fun i : Fin n => (H ^ (i : ℕ)) v)) :
    numRange (compress (krylovEmbedding H v (krylov_li_of_le hmn hli)) X)
        ⊆ numRange (compress (krylovEmbedding H v hli) X)
      ∧ numRange (compress (krylovEmbedding H v hli) X) ⊆ numRange X := by sorry
