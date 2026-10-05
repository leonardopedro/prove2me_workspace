-- Generated from ChapterFockFieldPerturbation.lean — theorem BookProof.FockFieldPerturbation.fieldVec_vac
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockInteractionStability
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockOneParticleGap
open BookProof.FockSecondQuantization
open BookProof.FockFieldPerturbation


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

theorem BookProof.FockFieldPerturbation.fieldVec_vac (k : ℕ) :
    fieldVec (Finsupp.single k 1) vac = Finsupp.single (Finsupp.single k 1) (1 : ℂ) := by sorry
