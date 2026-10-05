-- Generated from ChapterFockPairPerturbation.lean — theorem BookProof.FockPairPerturbation.pairVec_apply
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockInteractionStability
import Definitions.Def_ChapterFockFieldPerturbation
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization
open BookProof.FockPairPerturbation


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

theorem BookProof.FockPairPerturbation.pairVec_apply (f g : ℕ →₀ ℂ) (x : FockAlg) :
    pairVec f g x = creVec f (creVec g x) + annVec g (annVec f x) := by sorry
