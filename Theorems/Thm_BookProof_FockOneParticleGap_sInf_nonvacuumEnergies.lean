-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.sInf_nonvacuumEnergies
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap












noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.sInf_nonvacuumEnergies {e : ℕ → ℝ} (he : ∀ k, 0 ≤ e k) :
    sInf (nonvacuumEnergies e) = ⨅ k, e k := by sorry
