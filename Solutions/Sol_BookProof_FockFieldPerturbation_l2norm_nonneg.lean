-- Generated from ChapterFockFieldPerturbation.lean — solution of BookProof.FockFieldPerturbation.l2norm_nonneg
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
open BookProof.FockFieldPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

set_option maxHeartbeats 1000000 in
theorem solution (f : ℕ →₀ ℂ) : 0 ≤ l2norm f := Real.sqrt_nonneg _
