-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.matrixFlow_commute_of_commute
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow










open scoped BigOperators Matrix Matrix.Norms.Operator




variable {n : ℕ}

















variable {n : ℕ} (d : NSTruncation n)

set_option maxHeartbeats 1000000 in
theorem solution (A B : Matrix (Fin n) (Fin n) ℂ) (h : Commute A B)
    (t : ℝ) : Commute (matrixFlow A t) B := (h.smul_left t).exp_left
