-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.confNumber_zero
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution : confNumber (0 : Conf) = 0 := by

  simp [confNumber]
