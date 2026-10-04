-- Generated from ChapterFockPairPerturbation.lean — theorem BookProof.FockPairPerturbation.inner_creVec_left
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

theorem BookProof.FockPairPerturbation.inner_creVec_left (g : ℕ →₀ ℂ) (v u : FockAlg) :
    (inner ℂ (toLp (creVec g v)) (toLp u) : ℂ) = inner ℂ (toLp v) (toLp (annVec g u)) := by sorry
