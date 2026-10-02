-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.inv_comp_intertwine
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

set_option maxHeartbeats 1000000 in
omit [CompleteSpace F] [CompleteSpace G] in
theorem solution {A : F →L[ℂ] F} {B : G →L[ℂ] G} {Ai : F →L[ℂ] F} {Bi : G →L[ℂ] G}
    (P : G →L[ℂ] F) (hAl : Ai.comp A = ContinuousLinearMap.id ℂ F)
    (hBr : B.comp Bi = ContinuousLinearMap.id ℂ G)
    (hPB : P.comp B = A.comp P) :
    P.comp Bi = Ai.comp P := by

  calc P.comp Bi = Ai.comp ((A.comp P).comp Bi) := by
        rw [← ContinuousLinearMap.comp_assoc, ← ContinuousLinearMap.comp_assoc, hAl]
        simp
    _ = Ai.comp ((P.comp B).comp Bi) := by rw [hPB]
    _ = Ai.comp P := by rw [ContinuousLinearMap.comp_assoc, hBr]; simp
