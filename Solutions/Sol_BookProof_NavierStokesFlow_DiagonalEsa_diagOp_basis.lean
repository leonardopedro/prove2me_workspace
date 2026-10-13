-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.DiagonalEsa.diagOp_basis
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiagonalEsa



open scoped ENNReal
open BookProof.ChapterAbelianDiagonalCountable

set_option maxHeartbeats 1000000 in

theorem solution (c : ℕ → ℝ) (n : ℕ) : diagOp c (basis n) = ((c n : ℂ)) • basis n := by
  ext m
  by_cases hmn : m = n
  · subst hmn
    simp [diagOp, basis, diagFun, lp.single_apply]
    change ↑(c m) = c m • ((lp.single 2 m 1 : lp (fun _ : ℕ => ℂ) 2) : ℕ → ℂ) m
    simp [lp.single_apply]
  · simp [diagOp, basis, diagFun, lp.single_apply, Pi.single_eq_of_ne hmn]
    change 0 = c n • ((lp.single 2 n 1 : lp (fun _ : ℕ => ℂ) 2) : ℕ → ℂ) m
    simp [Pi.single_eq_of_ne hmn]
