-- Generated from ChapterFockFieldPerturbation.lean — solution of BookProof.FockFieldPerturbation.fieldVec_apply
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
open BookProof.FockFieldPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

set_option maxHeartbeats 1000000 in
theorem solution (f : ℕ →₀ ℂ) (x : FockAlg) :
    fieldVec f x = creVec f x + annVec f x := rfl
