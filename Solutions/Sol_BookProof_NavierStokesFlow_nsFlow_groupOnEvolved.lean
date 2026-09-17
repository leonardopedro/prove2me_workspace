-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.nsFlow_groupOnEvolved
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Theorems.Thm_BookProof_NavierStokesFlow_nsFlow_group
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution (t₁ t₂ : ℝ) (psi : Fin n → ℂ) :
    nsFlowUnitary d t₁ *ᵥ (nsFlowUnitary d t₂ *ᵥ psi) = nsFlowUnitary d (t₁ + t₂) *ᵥ psi := by

  rw [nsFlow_group, Matrix.mulVec_mulVec]
