-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.field_evaluates_to_value_diagonal
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]

theorem BookProof.NavierStokesFlow.field_evaluates_to_value_diagonal {m : ℕ} (xs : Fin 3 → Fin m → ℂ) (k : Fin m)
    (phi : (Fin m → ℂ) →ₗ[ℂ] (Fin m → ℂ)) (phiD : Fin 3 → (Fin m → ℂ) →ₗ[ℂ] (Fin m → ℂ)) :
    fieldTaylor phi phiD (fun i => Matrix.mulVecLin (Matrix.diagonal (xs i)))
        (fun i => xs i k) (Pi.single k 1)
      = phi (Pi.single k 1) := by sorry
