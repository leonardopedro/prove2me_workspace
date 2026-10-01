-- Generated from ChapterH8Bases.lean — theorem BookProof.ChapterH8.orthonormalEmbedding_adjoint_comp
import Mathlib
import Definitions.Def_ChapterH8Bases
open BookProof.ChapterH8

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap

theorem BookProof.ChapterH8.orthonormalEmbedding_adjoint_comp {m : ℕ} (w : Fin m → E) (hw : Orthonormal ℂ w) :
    (adjoint (orthonormalEmbedding w hw)).comp (orthonormalEmbedding w hw)
      = ContinuousLinearMap.id ℂ (EuclideanSpace ℂ (Fin m)) := by sorry
