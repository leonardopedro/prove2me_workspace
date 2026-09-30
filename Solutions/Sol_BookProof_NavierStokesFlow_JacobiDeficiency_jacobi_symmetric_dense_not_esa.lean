-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.JacobiDeficiency.jacobi_symmetric_dense_not_esa
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
import Theorems.Thm_BookProof_NavierStokesFlow_JacobiDeficiency_jacobiOp_symmetric
import Theorems.Thm_BookProof_NavierStokesFlow_JacobiDeficiency_jacobiOp_not_hasZeroDeficiencyOn
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency










open scoped ENNReal











open LpNat

set_option maxHeartbeats 1000000 in
theorem solution :
    Dense ((lpFiniteModes ℕ : Submodule ℂ L2N) : Set L2N) ∧
      (∀ x y : lpFiniteModes ℕ,
        (inner ℂ ((jacobiOp x : lpFiniteModes ℕ) : L2N) ((y : lpFiniteModes ℕ) : L2N) : ℂ)
          = inner ℂ ((x : lpFiniteModes ℕ) : L2N) ((jacobiOp y : lpFiniteModes ℕ) : L2N)) ∧
      ¬ HasZeroDeficiencyOn (lpFiniteModes ℕ) jacobiOp := ⟨lpFiniteModes_dense, jacobiOp_symmetric, jacobiOp_not_hasZeroDeficiencyOn⟩
