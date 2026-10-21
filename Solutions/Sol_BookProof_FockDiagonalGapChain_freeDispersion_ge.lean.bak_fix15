-- Generated from ChapterFockDiagonalGapChain.lean — solution of BookProof.FockDiagonalGapChain.freeDispersion_ge
import Mathlib
import Definitions.Def_ChapterFockDiagonalGapChain
open BookProof.FockDiagonalGapChain



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicQuarticStability BookProof.FockCubicUnbounded
open BookProof.FockInteractionStability
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HermiteGalerkin
open BookProof.HermiteCore BookProof.ScalaronFockGapChain
open Module


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {m : ℝ} (hm : 0 ≤ m) (p : ℕ → ℝ) (k : ℕ) :
    m ≤ freeDispersion m p k := by

  have h : m ^ 2 ≤ (p k) ^ 2 + m ^ 2 := by nlinarith [sq_nonneg (p k)]
  calc m = Real.sqrt (m ^ 2) := (Real.sqrt_sq hm).symm
    _ ≤ Real.sqrt ((p k) ^ 2 + m ^ 2) := Real.sqrt_le_sqrt h
