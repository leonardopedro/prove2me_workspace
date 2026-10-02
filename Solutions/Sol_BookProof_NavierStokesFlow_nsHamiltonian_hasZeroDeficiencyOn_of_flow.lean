-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.nsHamiltonian_hasZeroDeficiencyOn_of_flow
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Theorems.Thm_BookProof_NavierStokesFlow_hasZeroDeficiencyOn_of_completeUnitaryFlow
import Theorems.Thm_BookProof_NavierStokesFlow_nsFlowEuclidean_hasDerivAt
import Theorems.Thm_BookProof_NavierStokesFlow_nsFlowEuclidean_norm
import Theorems.Thm_BookProof_NavierStokesFlow_nsFlowEuclidean_zero
open BookProof.NavierStokesFlow



open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}
variable {n : ℕ} (d : NSTruncation n)

set_option maxHeartbeats 1000000 in
Lp.ofLp psi)) := by
    ext i
    simp [nsFlowEuclidean, Matrix.smul_mulVec]
  rw [heq]
  simpa [Function.comp_def, nsFlowEuclidean] using h2

theorem solution :=
  w :
      HasZeroDeficiencyOn (⊤ : Submodule ℂ (EuclideanSpace ℂ (Fin n)))
        (restrictToTop (Matrix.toEuclideanLin (nsHamiltonian d))) :=
    hasZeroDeficiencyOn_of_completeUnitaryFlow _ _ (nsFlowEuclidean d)
      (by simp) (fun t psi => nsFlowEuclidean_norm d t psi)
      (f
