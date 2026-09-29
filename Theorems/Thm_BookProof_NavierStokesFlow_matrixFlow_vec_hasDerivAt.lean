-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.matrixFlow_vec_hasDerivAt
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow









open scoped BigOperators Matrix Matrix.Norms.Operator




variable {n : ℕ}

theorem BookProof.NavierStokesFlow.matrixFlow_vec_hasDerivAt (A : Matrix (Fin n) (Fin n) ℂ) (x : Fin n → ℂ) (t : ℝ) :
    HasDerivAt (fun s : ℝ => matrixFlow A s *ᵥ x) (A *ᵥ (matrixFlow A t *ᵥ x)) t := by sorry
