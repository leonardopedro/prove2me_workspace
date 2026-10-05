-- Generated from ChapterFockFieldPerturbation.lean — theorem BookProof.FockFieldPerturbation.fieldVec_relative_form_bound
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

theorem BookProof.FockFieldPerturbation.fieldVec_relative_form_bound {col : ℕ → (ℕ →₀ ℂ)} {mu t : ℝ} (hmu : 0 < mu)
    (ht : 0 < t) (hgap : IsPosCol (shiftCol col mu)) (f : ℕ →₀ ℂ) (u : FockAlg) :
    |(inner ℂ (toLp u) (toLp (fieldVec f u)) : ℂ).re|
      ≤ t / mu * (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re
        + l2norm f ^ 2 / t * ‖toLp u‖ ^ 2 := by sorry
