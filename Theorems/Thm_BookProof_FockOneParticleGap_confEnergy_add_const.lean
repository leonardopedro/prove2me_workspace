-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.confEnergy_add_const
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap












noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.confEnergy_add_const (e : ℕ → ℝ) (mu : ℝ) (β : Conf) :
    confEnergy (fun k => e k + mu) β = confEnergy e β + mu * (confNumber β : ℝ) := by sorry
