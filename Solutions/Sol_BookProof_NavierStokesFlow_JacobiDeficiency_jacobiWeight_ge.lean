-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.JacobiDeficiency.jacobiWeight_ge
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency










open scoped ENNReal











open LpNat

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : (2 : ℝ) * 4 ^ n ≤ jacobiWeight n := by

  induction n with
  | zero => norm_num [jacobiWeight]
  | succ n ih => simp only [jacobiWeight, pow_succ]; linarith
