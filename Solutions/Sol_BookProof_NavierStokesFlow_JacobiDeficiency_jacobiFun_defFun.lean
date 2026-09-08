-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.JacobiDeficiency.jacobiFun_defFun
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency










open scoped ENNReal











open LpNat

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : jacobiFun defFun n = Complex.I * defFun n := by

  cases n with
  | zero =>
    simp only [jacobiFun, defFun, jacobiWeight, pow_one, pow_zero]
    push_cast
    ring
  | succ m =>
    simp only [jacobiFun, defFun, jacobiWeight, pow_succ]
    push_cast
    ring_nf
    rw [Complex.I_sq]
    ring
