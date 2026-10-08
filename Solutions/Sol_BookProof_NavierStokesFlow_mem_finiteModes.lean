-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.NavierStokesFlow



open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution : Dense ((finiteModes : Submodule ℂ L2Z) : Set L2Z) :=
  niteModes k c
  
  /-- The l
