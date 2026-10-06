-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.nsFlow_energy_conserved
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Theorems.Thm_BookProof_NavierStokesFlow_nsFlow_comm_hamiltonian
import Theorems.Thm_BookProof_NavierStokesFlow_nsFlow_unitary
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Matrix.Norms.Operator

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) (psi : Fin n → ℂ) :
    star (nsFlowUnitary d t *ᵥ psi) ⬝ᵥ (nsHamiltonian d *ᵥ (nsFlowUnitary d t *ᵥ psi))
      = star psi ⬝ᵥ (nsHamiltonian d *ᵥ psi) :=
  d evolution. -/
  theorem nsFlow_energy_conserved (t : ℝ) (psi : Fin n → ℂ) :
      star (nsFlowUnitary d t *ᵥ psi) ⬝ᵥ (nsHamiltonian d *ᵥ (nsFlowUnitary d t *ᵥ psi))
        = star psi ⬝ᵥ (nsHamiltonian d *ᵥ psi) := by
    have hstep : star (nsFlowUnitary d t *ᵥ psi) ⬝ᵥ (nsHamiltonian d *ᵥ (nsFlowUnitary d t *ᵥ psi))
        = star psi ⬝ᵥ (((nsFlowUnitary d t)ᴴ * nsHamiltonian d * nsFlowUnitary d t) *ᵥ psi) := by
      rw [Matrix
