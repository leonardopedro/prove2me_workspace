-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.field_evaluates_to_value_diagonal
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Theorems.Thm_BookProof_NavierStokesFlow_field_evaluates_to_value
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} (xs : Fin 3 → Fin m → ℂ) (k : Fin m)
    (phi : (Fin m → ℂ) →ₗ[ℂ] (Fin m → ℂ)) (phiD : Fin 3 → (Fin m → ℂ) →ₗ[ℂ] (Fin m → ℂ)) :
    fieldTaylor phi phiD (fun i => Matrix.mulVecLin (Matrix.diagonal (xs i)))
        (fun i => xs i k) (Pi.single k 1)
      = phi (Pi.single k 1) := by

  refine field_evaluates_to_value _ _ _ _ _ fun i => ?_
  funext j
  by_cases h : j = k <;> simp [Matrix.mulVec_diagonal, h]
