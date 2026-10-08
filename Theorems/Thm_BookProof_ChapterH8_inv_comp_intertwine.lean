-- Generated from ChapterH8.lean — theorem BookProof.ChapterH8.inv_comp_intertwine
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH6
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

theorem BookProof.ChapterH8.inv_comp_intertwine {A : F →L[ℂ] F} {B : G →L[ℂ] G} {Ai : F →L[ℂ] F} {Bi : G →L[ℂ] G}
    (P : G →L[ℂ] F) (hAl : Ai.comp A = ContinuousLinearMap.id ℂ F)
    (hBr : B.comp Bi = ContinuousLinearMap.id ℂ G)
    (hPB : P.comp B = A.comp P) :
    P.comp Bi = Ai.comp P := by sorry
