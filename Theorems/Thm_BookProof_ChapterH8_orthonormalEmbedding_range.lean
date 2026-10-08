-- Generated from ChapterH8Bases.lean — theorem BookProof.ChapterH8.orthonormalEmbedding_range
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH6
import Mathlib
import Definitions.Def_ChapterH8Bases
import Definitions.Def_ChapterH8
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap


theorem BookProof.ChapterH8.orthonormalEmbedding_range {m : ℕ} (w : Fin m → E) (hw : Orthonormal ℂ w) :
    LinearMap.range (orthonormalEmbedding w hw : EuclideanSpace ℂ (Fin m) →ₗ[ℂ] E)
      = Submodule.span ℂ (Set.range w) := by sorry
