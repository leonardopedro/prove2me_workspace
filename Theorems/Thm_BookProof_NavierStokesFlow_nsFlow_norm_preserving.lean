-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.nsFlow_norm_preserving
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

theorem BookProof.NavierStokesFlow.nsFlow_norm_preserving (t : ℝ) (psi : Fin n → ℂ) :
    ∑ a, ‖(nsFlowUnitary d t *ᵥ psi) a‖ ^ 2 = ∑ a, ‖psi a‖ ^ 2 := by sorry
