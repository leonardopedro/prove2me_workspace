-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.continuityHamiltonian_mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.NavierStokesFlow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}
variable {n : ℕ} (d : NSTruncation n)


open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

 refine hf.subset fun k hk => ?_
  simp only [Function.mem_support, velocityOp_apply] at hk
  exact fun hzero => hk (by rw [hzero, mul_zero])

/-- The continuity generator preserves the finite-mode domain. - := by sorry
