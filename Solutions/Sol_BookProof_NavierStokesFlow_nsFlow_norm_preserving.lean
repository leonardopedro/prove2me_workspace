-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.nsFlow_norm_preserving
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Theorems.Thm_BookProof_NavierStokesFlow_nsFlow_unitary
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) (psi : Fin n → ℂ) :
    ∑ a, ‖(nsFlowUnitary d t *ᵥ psi) a‖ ^ 2 = ∑ a, ‖psi a‖ ^ 2 := BookProof.ChapterContinuityUnitary.unitary_preserves_normSq _ (nsFlow_unitary d t) psi
