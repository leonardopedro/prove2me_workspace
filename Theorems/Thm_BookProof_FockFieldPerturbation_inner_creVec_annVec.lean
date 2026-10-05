-- Generated from ChapterFockFieldPerturbation.lean — theorem BookProof.FockFieldPerturbation.inner_creVec_annVec
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

theorem BookProof.FockFieldPerturbation.inner_creVec_annVec (f : ℕ →₀ ℂ) (u v : FockAlg) :
    (inner ℂ (toLp u) (toLp (creVec f v)) : ℂ) = inner ℂ (toLp (annVec f u)) (toLp v) := by sorry
