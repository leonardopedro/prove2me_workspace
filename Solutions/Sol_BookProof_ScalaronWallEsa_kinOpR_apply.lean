-- Generated from ChapterScalaronWallEsa.lean — solution of BookProof.ScalaronWallEsa.kinOpR_apply
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
open BookProof.ScalaronWallEsa













open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (f : 𝓢(ℝ, ℂ)) (x : ℝ) :
    (kinOpR f) x = -deriv (deriv (f : ℝ → ℂ)) x := by

  have h : kinOpR f
      = (∑ _i : Fin 1, ((-1 : ℝ) : ℂ) • secondDeriv (1 : ℝ) f) + ((0 : ℝ) : ℂ) • f := by
    simp [kinOpR, constCoeffOp]
  rw [h]
  simp [secondDeriv]
  rfl
