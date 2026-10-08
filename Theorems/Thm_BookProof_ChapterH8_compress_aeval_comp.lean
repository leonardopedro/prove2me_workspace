-- Generated from ChapterH8.lean — theorem BookProof.ChapterH8.compress_aeval_comp
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH6
import Mathlib
import Definitions.Def_ChapterH8
import Definitions.Def_ChapterH4
open BookProof.ChapterH4
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6
open ContinuousLinearMap

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

theorem BookProof.ChapterH8.compress_aeval_comp (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hVV : (adjoint V).comp V = ContinuousLinearMap.id ℂ F)
    (hinv : ∀ x : F, ∃ y : F, X (V x) = V y) (p : Polynomial ℂ) :
    (Polynomial.aeval X p).comp V = V.comp (Polynomial.aeval (compress V X) p) := by sorry
