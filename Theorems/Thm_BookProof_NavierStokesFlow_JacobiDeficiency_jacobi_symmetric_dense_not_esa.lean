-- Generated from ChapterNavierStokesDeficiency.lean — theorem BookProof.NavierStokesFlow.JacobiDeficiency.jacobi_symmetric_dense_not_esa
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency









open scoped ENNReal











open LpNat

theorem BookProof.NavierStokesFlow.JacobiDeficiency.jacobi_symmetric_dense_not_esa :
    Dense ((lpFiniteModes ℕ : Submodule ℂ L2N) : Set L2N) ∧
      (∀ x y : lpFiniteModes ℕ,
        (inner ℂ ((jacobiOp x : lpFiniteModes ℕ) : L2N) ((y : lpFiniteModes ℕ) : L2N) : ℂ)
          = inner ℂ ((x : lpFiniteModes ℕ) : L2N) ((jacobiOp y : lpFiniteModes ℕ) : L2N)) ∧
      ¬ HasZeroDeficiencyOn (lpFiniteModes ℕ) jacobiOp := by sorry
