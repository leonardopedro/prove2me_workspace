-- Generated from ChapterScalaronFockGapChain.lean — solution of BookProof.ScalaronFockGapChain.scalaronMass_pos
import Mathlib
import Definitions.Def_ChapterScalaronFockGapChain
open BookProof.ScalaronFockGapChain



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicQuarticStability BookProof.FockCubicUnbounded
open BookProof.FockInteractionStability
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HermiteGalerkin
open BookProof.HermiteCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {alpha : ℝ} (halpha : 0 < alpha) : 0 < scalaronMass alpha := by

  have h : 0 < Real.sqrt (12 * alpha) := Real.sqrt_pos.mpr (by linarith)
  exact div_pos one_pos h
