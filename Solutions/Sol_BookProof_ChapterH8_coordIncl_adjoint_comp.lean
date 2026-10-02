-- Generated from ChapterH8Bases.lean — solution of BookProof.ChapterH8.coordIncl_adjoint_comp
import Mathlib
import Definitions.Def_ChapterH8Bases
import Theorems.Thm_BookProof_ChapterH8_orthonormalEmbedding_adjoint_comp
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {m n : ℕ} (hmn : m ≤ n) :
    (adjoint (coordIncl hmn)).comp (coordIncl hmn)
      = ContinuousLinearMap.id ℂ (EuclideanSpace ℂ (Fin m)) := orthonormalEmbedding_adjoint_comp _ _
