-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.field_evaluates_to_value
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution (phi : E →ₗ[ℂ] E) (phiD : ι → E →ₗ[ℂ] E)
    (X : ι → E →ₗ[ℂ] E) (x : ι → ℂ) (v : E) (hv : ∀ i, X i v = x i • v) :
    fieldTaylor phi phiD X x v = phi v := by

  simp [fieldTaylor, LinearMap.sum_apply, hv]
