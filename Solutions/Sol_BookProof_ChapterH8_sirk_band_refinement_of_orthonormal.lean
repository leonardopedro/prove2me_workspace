-- Generated from ChapterH8Bases.lean — solution of BookProof.ChapterH8.sirk_band_refinement_of_orthonormal
import Mathlib
import Definitions.Def_ChapterH8Bases
import Theorems.Thm_BookProof_ChapterH8_orthonormalEmbedding_adjoint_comp
import Theorems.Thm_BookProof_ChapterH8_coordIncl_adjoint_comp
import Theorems.Thm_BookProof_ChapterH8_orthonormalEmbedding_nested
import Theorems.Thm_BookProof_ChapterH8_sirk_band_refinement_poly
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap

set_option maxHeartbeats 1000000 in
theorem solution {m n : ℕ} (hmn : m ≤ n) (X : E →L[ℂ] E)
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
          ((adjoint (orthonormalEmbedding w hw)) v)) :=
  sirk_band_refinement_poly (orthonormalEmbedding w hw) (orthonormalEmbedding w' hw')
      (coordIncl hmn) X (orthonormalEmbedding_nested hmn w w' hw hw' hnest)
      (orthonormalEmbedding_adjoint_comp w' hw') (coordIncl_adjoint_comp hmn)
      hinvm hinvn p v hv
