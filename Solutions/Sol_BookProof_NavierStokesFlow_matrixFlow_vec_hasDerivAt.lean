-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.matrixFlow_vec_hasDerivAt
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Theorems.Thm_BookProof_NavierStokesFlow_matrixFlow_hasDerivAt
import Theorems.Thm_BookProof_NavierStokesFlow_matrixFlow_comm
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Matrix.Norms.Operator

set_option maxHeartbeats 1000000 in
]
  simp [NormedSpace.exp_zero]

theorem solution (A : Matrix (Fin n) (Fin n) ℂ) (x : Fin n → ℂ) (t : ℝ) :
    HasDerivAt (fun s : ℝ => matrixFlow A s *ᵥ x) (A :=
   *ᵥ (matrixFlow A t *ᵥ x)) t := by
    have h := (applyVecCLM x).hasFDerivAt.comp_hasDerivAt t (matrixFlow_hasDerivAt A t)
    convert h using 1
