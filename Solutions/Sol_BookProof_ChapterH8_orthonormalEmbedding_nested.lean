-- Generated from ChapterH8Bases.lean — solution of BookProof.ChapterH8.orthonormalEmbedding_nested
import Mathlib
import Definitions.Def_ChapterH8Bases
import Theorems.Thm_BookProof_ChapterH8_orthonormalEmbedding_single
import Theorems.Thm_BookProof_ChapterH8_coordIncl_single
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap

set_option maxHeartbeats 1000000 in
theorem solution {m n : ℕ} (hmn : m ≤ n)
    (w : Fin m → E) (w' : Fin n → E) (hw : Orthonormal ℂ w) (hw' : Orthonormal ℂ w')
    (hnest : ∀ i : Fin m, w i = w' (Fin.castLE hmn i)) :
    orthonormalEmbedding w hw = (orthonormalEmbedding w' hw').comp (coordIncl hmn) := by

  refine ContinuousLinearMap.coe_injective ?_
  refine Module.Basis.ext (EuclideanSpace.basisFun (Fin m) ℂ).toBasis fun i => ?_
  have hb : ((EuclideanSpace.basisFun (Fin m) ℂ).toBasis) i
      = EuclideanSpace.single i (1 : ℂ) := by
    simp [EuclideanSpace.basisFun_apply]
  simp only [hb, ContinuousLinearMap.coe_coe, ContinuousLinearMap.coe_comp',
    Function.comp_apply]
  rw [orthonormalEmbedding_single, coordIncl_single, orthonormalEmbedding_single, hnest]
