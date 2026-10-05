-- Generated from ChapterFockPairPerturbation.lean — theorem BookProof.FockPairPerturbation.norm_creVec_sq
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

theorem BookProof.FockPairPerturbation.norm_creVec_sq (g : ℕ →₀ ℂ) (u : FockAlg) :
    ‖toLp (creVec g u)‖ ^ 2 = ‖toLp (annVec g u)‖ ^ 2 + l2sq g * ‖toLp u‖ ^ 2 := by sorry
