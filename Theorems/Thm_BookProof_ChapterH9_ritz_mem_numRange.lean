-- Generated from ChapterH9.lean — theorem BookProof.ChapterH9.ritz_mem_numRange
import Mathlib
import Definitions.Def_ChapterH9
open BookProof.ChapterH9


noncomputable section


open BookProof.ChapterH1 BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6
open BookProof.ChapterH8
open ContinuousLinearMap


variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

theorem BookProof.ChapterH9.ritz_mem_numRange (V : F →L[ℂ] E) (X : E →L[ℂ] E) (hViso : ∀ x : F, ‖V x‖ = ‖x‖)
    {lam : ℂ} {y : F} (hy : ‖y‖ = 1) (heig : compress V X y = lam • y) :
    lam ∈ numRange X := by sorry
