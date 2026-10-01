-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.creA_annA_single
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.creA_annA_single (k : ℕ) (β : Conf) (c : ℂ) :
    creA k (annA k (Finsupp.single β c)) = ((β k : ℝ) : ℂ) • Finsupp.single β c := by sorry
