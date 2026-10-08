-- Generated from ChapterF3.lean — solution of BookProof.ChapterF3.mehler_projector_matrix
import Mathlib
import Definitions.Def_ChapterF3
open BookProof.ChapterF3



open scoped BigOperators
open Polynomial


noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {E' : Type*} [NormedAddCommGroup E'] [InnerProductSpace ℂ E']

set_option maxHeartbeats 1000000 in
theorem solution (v xi xj : E') :
    inner (𝕜 :=
  ℂ) xi (projOnto v xj)
        = (starRingEnd ℂ) (inner (𝕜 := ℂ) v xi) * inner (𝕜 := ℂ) v xj := by
    simp [ projOnto ];
    ring
