-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.dGamma_diagCol_one_particle
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.dGamma_diagCol_one_particle (e : ℕ → ℝ) (k : ℕ) :
    dGamma (diagCol e) (Finsupp.single (Finsupp.single k 1) (1 : ℂ))
      = ((e k : ℝ) : ℂ) • Finsupp.single (Finsupp.single k 1) (1 : ℂ) := by sorry
