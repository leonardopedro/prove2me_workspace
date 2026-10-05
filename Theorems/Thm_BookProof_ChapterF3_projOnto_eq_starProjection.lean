-- Generated from ChapterF3.lean — theorem BookProof.ChapterF3.projOnto_eq_starProjection
import Mathlib
import Definitions.Def_ChapterF3
open BookProof.ChapterF3

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


open scoped BigOperators
open Polynomial


noncomputable section

theorem BookProof.ChapterF3.projOnto_eq_starProjection {ψ : E} (hψ : ‖ψ‖ = 1) (s : E) :
    projOnto ψ s = (Submodule.span ℂ {ψ}).starProjection s := by sorry
