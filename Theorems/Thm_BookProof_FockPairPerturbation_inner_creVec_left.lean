-- Generated from ChapterFockPairPerturbation.lean — theorem BookProof.FockPairPerturbation.inner_creVec_left
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

theorem BookProof.FockPairPerturbation.inner_creVec_left (g : ℕ →₀ ℂ) (v u : FockAlg) :
    (inner ℂ (toLp (creVec g v)) (toLp u) : ℂ) = inner ℂ (toLp v) (toLp (annVec g u)) := by sorry
