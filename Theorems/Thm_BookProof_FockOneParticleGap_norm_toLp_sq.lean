-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.norm_toLp_sq
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap












noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.norm_toLp_sq (u : FockAlg) : ‖toLp u‖ ^ 2 = ∑ α ∈ u.support, ‖u α‖ ^ 2 := by sorry
