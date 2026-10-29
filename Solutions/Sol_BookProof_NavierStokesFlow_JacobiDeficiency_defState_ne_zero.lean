-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.JacobiDeficiency.defState_ne_zero
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency



open scoped ENNReal
open BookProof.NavierStokesFlow.DiagonalEsa
open BookProof.NavierStokesFlow.LpNat

set_option maxHeartbeats 1000000 in

@[simp] private theorem defState_coe : ((defState : L2N) : ℕ → ℂ) = defFun := rfl

theorem solution : defState ≠ 0 := by
  intro h
  have h0 : ((defState : L2N) : ℕ → ℂ) 0 = 0 := by rw [h]; simp
  simp [defState_coe, defFun] at h0
