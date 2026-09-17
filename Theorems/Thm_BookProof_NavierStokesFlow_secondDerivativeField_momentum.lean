-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.secondDerivativeField_momentum
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

theorem BookProof.NavierStokesFlow.secondDerivativeField_momentum (i j k l m n : Fin 3)
    (p : MvPolynomial (Fin 3 × Fin 3 × Fin 3) ℂ) :
    (MvPolynomial.pderiv (l, m, n)) (MvPolynomial.X (i, j, k) * p)
      - MvPolynomial.X (i, j, k) * (MvPolynomial.pderiv (l, m, n)) p
      = (if l = i ∧ m = j ∧ n = k then p else 0) := by sorry
