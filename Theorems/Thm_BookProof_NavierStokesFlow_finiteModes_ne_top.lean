-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.finiteModes_ne_top
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.NavierStokesFlow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}
variable {n : ℕ} (d : NSTruncation n)


open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

tice finite-mode domain is dense. -/
theorem BookProof.NavierStokesFlow.finiteModes_ne_top : Dense ((finiteModes : Submodule ℂ L2Z) : Set L2Z) :=
  lpFiniteModes_dense

/-- The finite-mode domain is a **proper** subspa := by sorry
