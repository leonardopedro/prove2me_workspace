-- Generated from ChapterFockPairPerturbation.lean — solution of BookProof.FockPairPerturbation.pairVec_apply
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
open BookProof.FockPairPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution (f g : ℕ →₀ ℂ) (x : FockAlg) :
    pairVec f g x = creVec f (creVec g x) + annVec g (annVec f x) := rfl
