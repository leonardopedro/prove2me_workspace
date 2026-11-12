-- Generated from ChapterF3.lean — theorem BookProof.ChapterF3.projOnto_isSymmetric
import Mathlib
import Definitions.Def_ChapterF3
open BookProof.ChapterF3


open scoped BigOperators
open Polynomial


noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

theorem BookProof.ChapterF3.projOnto_isSymmetric (ψ : E) (x y : E) :
    inner (𝕜 := ℂ) (projOnto ψ x) y = inner (𝕜 := ℂ) x (projOnto ψ y) := by sorry
