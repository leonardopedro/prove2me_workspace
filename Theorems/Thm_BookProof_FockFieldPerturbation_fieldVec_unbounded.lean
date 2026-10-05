-- Generated from ChapterFockFieldPerturbation.lean — theorem BookProof.FockFieldPerturbation.fieldVec_unbounded
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

theorem BookProof.FockFieldPerturbation.fieldVec_unbounded (k : ℕ) (C : ℝ) :
    ∃ u : FockAlg, ‖toLp u‖ = 1 ∧ C ≤ ‖toLp (fieldVec (Finsupp.single k 1) u)‖ := by sorry
