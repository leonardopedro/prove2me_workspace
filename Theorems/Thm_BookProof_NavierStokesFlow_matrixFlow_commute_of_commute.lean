-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.matrixFlow_commute_of_commute
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow









open scoped BigOperators Matrix Matrix.Norms.Operator




variable {n : ℕ}

















variable {n : ℕ} (d : NSTruncation n)

theorem BookProof.NavierStokesFlow.matrixFlow_commute_of_commute (A B : Matrix (Fin n) (Fin n) ℂ) (h : Commute A B)
    (t : ℝ) : Commute (matrixFlow A t) B := by sorry
