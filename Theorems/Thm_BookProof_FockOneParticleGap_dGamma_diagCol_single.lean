-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.dGamma_diagCol_single
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.dGamma_diagCol_single (e : ℕ → ℝ) (β : Conf) (c : ℂ) :
    dGamma (diagCol e) (Finsupp.single β c)
      = ((confEnergy e β : ℝ) : ℂ) • Finsupp.single β c := by sorry
