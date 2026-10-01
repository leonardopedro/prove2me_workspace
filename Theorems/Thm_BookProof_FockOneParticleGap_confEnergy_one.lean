-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.confEnergy_one
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.confEnergy_one (β : Conf) : confEnergy (fun _ => 1) β = (confNumber β : ℝ) := by sorry
