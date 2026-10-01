-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.iInf_le_confEnergy
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.iInf_le_confEnergy {e : ℕ → ℝ} (he : ∀ k, 0 ≤ e k) {β : Conf} (hβ : β ≠ 0) :
    (⨅ k, e k) ≤ confEnergy e β := by sorry
