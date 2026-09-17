-- Generated from ChapterH9.lean — solution of BookProof.ChapterH9.mem_numRange
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

set_option maxHeartbeats 1000000 in
theorem solution {X : E →L[ℂ] E} (x : E) (hx : ‖x‖ = 1) :
    (inner ℂ x (X x) : ℂ) ∈ numRange X := ⟨x, hx, rfl⟩
