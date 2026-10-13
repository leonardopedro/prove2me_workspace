-- Generated from ChapterFockFieldPerturbation.lean — solution of BookProof.FockFieldPerturbation.annVec_apply
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockInteractionStability
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockFieldPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockSecondQuantization

set_option maxHeartbeats 1000000 in
theorem solution (f : ℕ →₀ ℂ) (x : FockAlg) :
    annVec f x = ∑ j ∈ f.support, ((starRingEnd ℂ) (f j)) • annA j x := by

  simp [annVec, LinearMap.sum_apply]
