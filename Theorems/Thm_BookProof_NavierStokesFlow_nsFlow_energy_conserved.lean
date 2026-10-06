-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.nsFlow_energy_conserved
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)


open scoped BigOperators Matrix Matrix.Norms.Operator

theorem BookProof.NavierStokesFlow.nsFlow_energy_conserved (t : ℝ) (psi : Fin n → ℂ) :
    star (nsFlowUnitary d t *ᵥ psi) ⬝ᵥ (nsHamiltonian d *ᵥ (nsFlowUnitary d t *ᵥ psi))
      = star psi ⬝ᵥ (nsHamiltonian d *ᵥ psi) := by sorry
