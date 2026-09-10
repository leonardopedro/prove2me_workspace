-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.dGamma_diagCol_apply
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap












noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.dGamma_diagCol_apply (e : ℕ → ℝ) (u : FockAlg) (β : Conf) :
    dGamma (diagCol e) u β = ((confEnergy e β : ℝ) : ℂ) * u β := by sorry
