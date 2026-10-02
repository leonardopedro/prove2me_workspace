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
 * nsHamiltonian d = nsHamiltonian d * nsFlowUnitary d t := by
  rw [nsFlowUnitary_eq_matrixFlow]
  exact (matrixFlow_commute_of_commute (Complex.I • nsHamiltonian d) (nsHamiltonian d)
    (by simp [Commute, SemiconjBy]) t).eq

/-- **D.12** *Conservation of energy along the truncated flow*: the expectation
`⟨ψ(t), H_N ψ(t)⟩` of the Navier–Stokes Hamiltonian is the same at every time.
With `nsFlow_norm_preserving` this is the second conserved quantity of the
truncate :=
  d evolution. -/
  theorem nsFlow_energy_conserved (t : ℝ) (psi : Fin n → ℂ) :
      star (nsFlowUnitary d t *ᵥ psi) ⬝ᵥ (nsHamiltonian d *ᵥ (nsFlowUnitary d t *ᵥ psi))
        = star psi ⬝ᵥ (nsHamiltonian d *ᵥ psi) := by
    have hstep : star (nsFlowUnitary d t *ᵥ psi) ⬝ᵥ (nsHamiltonian d *ᵥ (nsFlowUnitary d t *ᵥ psi))
        = star psi ⬝ᵥ (((nsFlowUnitary d t)ᴴ * nsHamiltonian d * nsFlowUnitary d t) *ᵥ psi) := by
      rw [Matrix
