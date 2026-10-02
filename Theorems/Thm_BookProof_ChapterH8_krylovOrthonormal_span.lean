-- Generated from ChapterH8Bases.lean — theorem BookProof.ChapterH8.krylovOrthonormal_span
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

theorem BookProof.ChapterH8.krylovOrthonormal_span (H : E →ₗ[ℂ] E) (v : E) (n : ℕ) :
    Submodule.span ℂ (Set.range (fun i : Fin n => krylovOrthonormalSeq H v (i : ℕ)))
      = krylovSpan H v n := by sorry
