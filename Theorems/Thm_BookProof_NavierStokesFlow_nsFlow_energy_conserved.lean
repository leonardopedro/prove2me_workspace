-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.nsFlow_energy_conserved
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)
variable (L : LagrangianNS n)


open scoped BigOperators Matrix Matrix.Norms.Operator

 * nsHamiltonian d = nsHamiltonian d * nsFlowUnitary d t := by
  rw [nsFlowUnitary_eq_matrixFlow]
  exact (matrixFlow_commute_of_commute (Complex.I • nsHamiltonian d) (nsHamiltonian d)
    (by simp [Commute, SemiconjBy]) t).eq

/-- **D.12** *Conservation of energy along the truncated flow*: the expectation
`⟨ψ(t), H_N ψ(t)⟩` of the Navier–Stokes Hamiltonian is the same at every time.
With `nsFlow_norm_preserving` this is the second conserved quantity of the
truncate := by sorry
