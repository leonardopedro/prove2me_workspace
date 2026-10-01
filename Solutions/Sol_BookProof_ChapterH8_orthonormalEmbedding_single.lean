-- Generated from ChapterH8Bases.lean — solution of BookProof.ChapterH8.orthonormalEmbedding_single
import Mathlib
import Definitions.Def_ChapterH8Bases
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} (w : Fin m → E) (hw : Orthonormal ℂ w) (i : Fin m) :
    orthonormalEmbedding w hw (EuclideanSpace.single i (1 : ℂ)) = w i := by

  simp [orthonormalEmbedding, orthonormalEmbeddingLI, LinearMap.isometryOfOrthonormal,
    LinearIsometry.toContinuousLinearMap]
