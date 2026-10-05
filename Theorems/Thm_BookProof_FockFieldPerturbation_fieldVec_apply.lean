-- Generated from ChapterFockFieldPerturbation.lean — theorem BookProof.FockFieldPerturbation.fieldVec_apply
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

theorem BookProof.FockFieldPerturbation.fieldVec_apply (f : ℕ →₀ ℂ) (x : FockAlg) :
    fieldVec f x = creVec f x + annVec f x := by sorry
