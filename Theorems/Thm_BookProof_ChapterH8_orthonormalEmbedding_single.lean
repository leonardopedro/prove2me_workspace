-- Generated from ChapterH8Bases.lean — theorem BookProof.ChapterH8.orthonormalEmbedding_single
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH6
import Mathlib
import Definitions.Def_ChapterH8Bases
import Definitions.Def_ChapterH8
open BookProof.ChapterH8

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6




open ContinuousLinearMap

theorem BookProof.ChapterH8.orthonormalEmbedding_single {m : ℕ} (w : Fin m → E) (hw : Orthonormal ℂ w) (i : Fin m) :
    orthonormalEmbedding w hw (EuclideanSpace.single i (1 : ℂ)) = w i := by sorry
