-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.nsDivergenceConstraint_resolution_matrix
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution (U11 U22 U33 : Matrix (Fin n) (Fin n) ℂ)
    (h : U33 = -(U11 + U22)) : U11 + U22 + U33 = 0 := by

  rw [h]; abel
