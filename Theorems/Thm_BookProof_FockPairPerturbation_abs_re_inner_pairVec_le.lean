-- Generated from ChapterFockPairPerturbation.lean — theorem BookProof.FockPairPerturbation.abs_re_inner_pairVec_le
import Definitions.Def_ChapterFockOneParticleGap
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterA4
open BookProof.FockSecondQuantization
open BookProof.FockPairPerturbation


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockFieldPerturbation

theorem BookProof.FockPairPerturbation.abs_re_inner_pairVec_le (f g : ℕ →₀ ℂ) (u : FockAlg) :
    |(inner ℂ (toLp u) (toLp (pairVec f g u)) : ℂ).re|
      ≤ 2 * (l2norm f * l2norm g)
          * (Real.sqrt (numberQuad u) * Real.sqrt (numberQuad u + ‖toLp u‖ ^ 2)) := by sorry
