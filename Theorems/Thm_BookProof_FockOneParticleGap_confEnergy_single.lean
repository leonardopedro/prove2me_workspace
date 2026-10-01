-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.confEnergy_single
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.confEnergy_single (e : ℕ → ℝ) (k : ℕ) :
    confEnergy e (Finsupp.single k 1) = e k := by sorry
