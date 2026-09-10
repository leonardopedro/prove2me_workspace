-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.confEnergy_one
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (β : Conf) : confEnergy (fun _ => 1) β = (confNumber β : ℝ) := by

  simp [confEnergy, confNumber]
