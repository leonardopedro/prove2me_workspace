-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.JacobiDeficiency.defState_ne_zero
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency










open scoped ENNReal











open LpNat

set_option maxHeartbeats 1000000 in
theorem solution : defState ≠ 0 := by

  intro h
  have h0 : ((defState : L2N) : ℕ → ℂ) 0 = 0 := by rw [h]; simp
  simp [defState_coe, defFun] at h0
