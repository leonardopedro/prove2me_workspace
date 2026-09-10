-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.confEnergy_zero
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ → ℝ) : confEnergy e (0 : Conf) = 0 := by

  simp [confEnergy]
