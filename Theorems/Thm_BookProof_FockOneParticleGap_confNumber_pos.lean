-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.confNumber_pos
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.confNumber_pos {β : Conf} (h : β ≠ 0) : 1 ≤ confNumber β := by sorry
