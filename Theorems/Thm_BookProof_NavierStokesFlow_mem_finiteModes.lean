-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.NavierStokesFlow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}
variable {n : ℕ} (d : NSTruncation n)


open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

).Finite := Iff.rfl

theorem BookProof.NavierStokesFlow.mem_finiteModes (k : ℤ) (c : ℂ) : lp.single 2 k c ∈ finiteModes :=
  lpSingle_mem_lpFi := by sorry
