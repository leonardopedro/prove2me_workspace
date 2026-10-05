-- Generated from ChapterFockPairPerturbation.lean — theorem BookProof.FockPairPerturbation.pairVec_relative_form_bound
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

theorem BookProof.FockPairPerturbation.pairVec_relative_form_bound {col : ℕ → (ℕ →₀ ℂ)} {mu : ℝ} (hmu : 0 < mu)
    (hgap : IsPosCol (shiftCol col mu)) (f g : ℕ →₀ ℂ) {u : FockAlg} (h0 : u 0 = 0) :
    |(inner ℂ (toLp u) (toLp (pairVec f g u)) : ℂ).re|
      ≤ (2 * Real.sqrt 2 * (l2norm f * l2norm g) / mu)
          * (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re := by sorry
