-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.le_confEnergy
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap












noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.le_confEnergy {e : ℕ → ℝ} {mu : ℝ} (hmu : 0 ≤ mu) (he : ∀ k, mu ≤ e k)
    {β : Conf} (hβ : β ≠ 0) : mu ≤ confEnergy e β := by sorry
