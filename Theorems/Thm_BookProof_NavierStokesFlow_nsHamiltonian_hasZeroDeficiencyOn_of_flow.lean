-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.nsHamiltonian_hasZeroDeficiencyOn_of_flow
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.NavierStokesFlow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}
variable {n : ℕ} (d : NSTruncation n)


open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

Lp.ofLp psi)) := by
    ext i
    simp [nsFlowEuclidean, Matrix.smul_mulVec]
  rw [heq]
  simpa [Function.comp_def, nsFlowEuclidean] using h2

theorem BookProof.NavierStokesFlow.nsHamiltonian_hasZeroDeficiencyOn_of_flow := by sorry
