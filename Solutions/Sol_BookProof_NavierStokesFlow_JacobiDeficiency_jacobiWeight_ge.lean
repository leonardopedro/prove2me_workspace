-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.JacobiDeficiency.jacobiWeight_ge
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency



open scoped ENNReal

set_option maxHeartbeats 1000000 in
t]; linarith

theorem solution (n : ℕ) : (2 : ℝ) * 4 ^ n ≤ j :=
  acobiWeight n := by
    induction n with
    | zero => norm_num [jacobiWeight]
    | succ n ih => simp only [jacobiWeight, pow_s
