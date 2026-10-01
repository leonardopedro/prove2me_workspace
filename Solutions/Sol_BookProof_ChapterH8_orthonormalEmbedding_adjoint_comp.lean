-- Generated from ChapterH8Bases.lean — solution of BookProof.ChapterH8.orthonormalEmbedding_adjoint_comp
import Mathlib
import Definitions.Def_ChapterH8Bases
import Theorems.Thm_BookProof_ChapterH8_orthonormalEmbedding_inner
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} (w : Fin m → E) (hw : Orthonormal ℂ w) :
    (adjoint (orthonormalEmbedding w hw)).comp (orthonormalEmbedding w hw)
      = ContinuousLinearMap.id ℂ (EuclideanSpace ℂ (Fin m)) :=
  ContinuousLinearMap.ext fun x => by
      refine ext_inner_right ℂ fun y => ?_
      rw [ContinuousLinearMap.coe_comp', Function.comp_apply, adjoint_inner_left]
      simpa using orthonormalEmbedding_inner w hw x y
