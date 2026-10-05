-- Generated from ChapterFockFieldPerturbation.lean — theorem BookProof.FockFieldPerturbation.annVec_apply
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockInteractionStability
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization
open BookProof.FockFieldPerturbation


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

theorem BookProof.FockFieldPerturbation.annVec_apply (f : ℕ →₀ ℂ) (x : FockAlg) :
    annVec f x = ∑ j ∈ f.support, ((starRingEnd ℂ) (f j)) • annA j x := by sorry
