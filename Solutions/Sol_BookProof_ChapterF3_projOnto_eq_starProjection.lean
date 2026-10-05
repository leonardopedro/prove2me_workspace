-- Generated from ChapterF3.lean — solution of BookProof.ChapterF3.projOnto_eq_starProjection
import Mathlib
import Definitions.Def_ChapterF3
open BookProof.ChapterF3



open scoped BigOperators
open Polynomial


noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {ψ : E} (hψ : ‖ψ‖ = 1) (s : E) :
    projOnto ψ s = (Submodule.span ℂ {ψ}).starProjection s := by

  rw [ Submodule.starProjection_singleton ] ; aesop
