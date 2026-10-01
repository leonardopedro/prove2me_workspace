-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.NavierStokesFlow



open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
).Finite := Iff.rfl

theorem solution (k : ℤ) (c : ℂ) : lp.single 2 k c ∈ finiteModes :=
  lpSingle_mem_lpFi :=
  niteModes k c
  
  /-- The l
