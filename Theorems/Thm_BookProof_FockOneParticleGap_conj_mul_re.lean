-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.conj_mul_re
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.conj_mul_re (z : ℂ) : ((starRingEnd ℂ) z * z).re = ‖z‖ ^ 2 := by sorry
