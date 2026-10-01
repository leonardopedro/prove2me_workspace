-- Generated from ChapterH8Bases.lean — theorem BookProof.ChapterH8.krylovEmbedding_range
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterH6
import Mathlib
import Definitions.Def_ChapterH8Bases
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH8
open BookProof.ChapterH5
open BookProof.ChapterH8

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6




open ContinuousLinearMap

 in
theorem BookProof.ChapterH8.krylovEmbedding_range (H : E →ₗ[ℂ] E) (v : E) {n : ℕ}
    (hli : LinearIndependent ℂ (fun i : Fin n => (H ^ (i : ℕ)) v)) :
    LinearMap.range (krylovEmbedding H v hli : EuclideanSpace ℂ (Fin n) →ₗ[ℂ] E)
      = krylovSpan H v n := by
  rw [krylovEmbe := by sorry
