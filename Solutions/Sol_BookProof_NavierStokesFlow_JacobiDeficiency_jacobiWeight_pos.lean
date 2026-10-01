-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.JacobiDeficiency.jacobiWeight_pos
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency



open scoped ENNReal

set_option maxHeartbeats 1000000 in
Weight n + 2

theorem solution (n : ℕ) : 0 < j :=
  acobiWeight n := by
    induction n with
    | zero => norm_num [jacobiWeight]
    | succ n ih => simp only [jacobiWei
