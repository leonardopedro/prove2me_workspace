-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.nsFlow_solves_schrodinger
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow









open scoped BigOperators Matrix Matrix.Norms.Operator




variable {n : ℕ}

















variable {n : ℕ} (d : NSTruncation n)

theorem BookProof.NavierStokesFlow.nsFlow_solves_schrodinger (psi : Fin n → ℂ) (t : ℝ) :
    HasDerivAt (fun s : ℝ => nsFlowUnitary d s *ᵥ psi)
      ((Complex.I • nsHamiltonian d) *ᵥ (nsFlowUnitary d t *ᵥ psi)) t := by sorry
