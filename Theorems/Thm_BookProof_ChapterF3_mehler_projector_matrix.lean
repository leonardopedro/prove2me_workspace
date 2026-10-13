-- Generated from ChapterF3.lean —
import Mathlib
import Definitions.Def_ChapterF3
import Definitions.Def_ChapterGhostField
open BookProof.GhostField
open BookProof.ChapterF3


open scoped BigOperators
open Polynomial


noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {E' : Type*} [NormedAddCommGroup E'] [InnerProductSpace ℂ E']

theorem BookProof.ChapterF3.mehler_projector_matrix (v xi xj : E') :
    inner (𝕜 := ℂ) xi (projOnto v xj)
      = (starRingEnd ℂ) (inner (𝕜 := ℂ) v xi) * inner (𝕜 := ℂ) v xj := by sorry
