-- Generated from ChapterF3.lean — theorem BookProof.ChapterF3.projOnto_idempotent
import Mathlib
import Definitions.Def_ChapterF3
open BookProof.ChapterF3


open scoped BigOperators
open Polynomial


noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

theorem BookProof.ChapterF3.projOnto_idempotent {ψ : E} (hψ : ‖ψ‖ = 1) (s : E) :
    projOnto ψ (projOnto ψ s) = projOnto ψ s := by sorry
