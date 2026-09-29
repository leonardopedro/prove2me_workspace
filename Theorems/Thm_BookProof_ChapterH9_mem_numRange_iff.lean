-- Generated from ChapterH9.lean — theorem BookProof.ChapterH9.mem_numRange_iff
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

theorem BookProof.ChapterH9.mem_numRange_iff {X : E →L[ℂ] E} {c : ℂ} :
    c ∈ numRange X ↔ ∃ x : E, ‖x‖ = 1 ∧ (inner ℂ x (X x) : ℂ) = c := by sorry
