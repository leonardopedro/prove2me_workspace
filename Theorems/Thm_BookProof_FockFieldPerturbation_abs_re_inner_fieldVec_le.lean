-- Generated from ChapterFockFieldPerturbation.lean — theorem BookProof.FockFieldPerturbation.abs_re_inner_fieldVec_le
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

theorem BookProof.FockFieldPerturbation.abs_re_inner_fieldVec_le (f : ℕ →₀ ℂ) (u : FockAlg) :
    |(inner ℂ (toLp u) (toLp (fieldVec f u)) : ℂ).re|
      ≤ 2 * l2norm f * Real.sqrt (numberQuad u) * ‖toLp u‖ := by sorry
