-- Generated from ChapterFockPairPerturbation.lean — theorem BookProof.FockPairPerturbation.annVec_creVec
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

theorem BookProof.FockPairPerturbation.annVec_creVec (g : ℕ →₀ ℂ) (u : FockAlg) :
    annVec g (creVec g u) = creVec g (annVec g u) + ((l2sq g : ℝ) : ℂ) • u := by sorry
