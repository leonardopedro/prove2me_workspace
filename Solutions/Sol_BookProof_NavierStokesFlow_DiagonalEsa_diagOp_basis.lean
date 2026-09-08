-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.DiagonalEsa.diagOp_basis
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiagonalEsa










open scoped ENNReal











open LpNat





























open LpNat

set_option maxHeartbeats 1000000 in
theorem solution (c : ℕ → ℝ) (n : ℕ) : diagOp c (basis n) = ((c n : ℂ)) • basis n := by

  ext m
  by_cases hmn : m = n
  · subst hmn
    simp [diagOp, basis, diagFun, lp.single_apply]
  · simp [diagOp, basis, diagFun, lp.single_apply, Pi.single_eq_of_ne hmn]
