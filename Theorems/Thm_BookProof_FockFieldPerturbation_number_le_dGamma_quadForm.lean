-- Generated from ChapterFockFieldPerturbation.lean — theorem BookProof.FockFieldPerturbation.number_le_dGamma_quadForm
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

theorem BookProof.FockFieldPerturbation.number_le_dGamma_quadForm {col : ℕ → (ℕ →₀ ℂ)} {mu : ℝ}
    (hgap : IsPosCol (shiftCol col mu)) (u : FockAlg) :
    mu * numberQuad u ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re := by sorry
