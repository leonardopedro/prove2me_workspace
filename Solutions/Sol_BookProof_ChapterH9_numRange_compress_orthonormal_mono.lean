-- Generated from ChapterH9.lean — solution of BookProof.ChapterH9.numRange_compress_orthonormal_mono
import Mathlib
import Definitions.Def_ChapterH9
import Theorems.Thm_BookProof_ChapterH9_numRange_compress_mono
import Theorems.Thm_BookProof_ChapterH9_coordIncl_norm_map
open BookProof.ChapterH9



noncomputable section


open BookProof.ChapterH1 BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6
open BookProof.ChapterH8
open ContinuousLinearMap


variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

set_option maxHeartbeats 1000000 in
theorem solution {m n : ℕ} (hmn : m ≤ n) (X : E →L[ℂ] E)
    (w : Fin m → E) (w' : Fin n → E) (hw : Orthonormal ℂ w) (hw' : Orthonormal ℂ w')
    (hnest : ∀ i : Fin m, w i = w' (Fin.castLE hmn i)) :
    numRange (compress (orthonormalEmbedding w hw) X)
      ⊆ numRange (compress (orthonormalEmbedding w' hw') X) :=
  numRange_compress_mono _ _ (coordIncl hmn) X
      (orthonormalEmbedding_nested hmn w w' hw hw' hnest) (coordIncl_norm_map hmn)
