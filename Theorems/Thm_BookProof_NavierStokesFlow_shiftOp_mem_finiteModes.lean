-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.shiftOp_mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.NavierStokesFlow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}
variable {n : ℕ} (d : NSTruncation n)


open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

pa [hgdef, Function.mem_support] using one_div_ne_zero hkC
  exact (Set.infinite_univ.diff (Set.finite_singleton (0 : ℤ))) (hg.subset hsub)

/-- The lattice translation prese := by sorry
