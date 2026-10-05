-- Generated from ChapterF3.lean — theorem BookProof.ChapterF3.mehler_projector_matrix
import Mathlib
import Definitions.Def_ChapterF3
open BookProof.ChapterF3

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {E' : Type*} [NormedAddCommGroup E'] [InnerProductSpace ℂ E']


open scoped BigOperators
open Polynomial


noncomputable section

theorem BookProof.ChapterF3.mehler_projector_matrix (v xi xj : E') :
    inner (𝕜 := by sorry
