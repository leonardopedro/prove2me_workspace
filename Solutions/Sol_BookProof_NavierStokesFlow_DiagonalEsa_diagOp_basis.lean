-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.DiagonalEsa.diagOp_basis
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiagonalEsa



open scoped ENNReal

set_option maxHeartbeats 1000000 in
n 1⟩

theorem solution (c : ℕ → ℝ) (n : ℕ) : diagOp c (basis n) = ((c n : ℂ)) • :=
  basis n := by
    ext m
    by_cases hmn : m = n
    · subst hmn
      simp [diagOp, basis, diagFun, lp.single_apply]
      change ↑(c m) = c m • ((lp.single 2 m 1 : lp (fun _ : ℕ =
