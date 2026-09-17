-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.derivativeField_momentum
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

theorem BookProof.NavierStokesFlow.derivativeField_momentum (j k m n : Fin 3) (p : MvPolynomial (Fin 3 × Fin 3) ℂ) :
    (MvPolynomial.pderiv (m, n)) (MvPolynomial.X (j, k) * p)
      - MvPolynomial.X (j, k) * (MvPolynomial.pderiv (m, n)) p
      = (if m = j ∧ n = k then p else 0) := by sorry
