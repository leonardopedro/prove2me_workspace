-- Generated from ChapterFockPairPerturbation.lean — theorem BookProof.FockPairPerturbation.creVec_single_one
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockInteractionStability
import Definitions.Def_ChapterFockFieldPerturbation
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization
open BookProof.FockPairPerturbation

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

theorem BookProof.FockPairPerturbation.creVec_single_one (k : ℕ) (w : FockAlg) :
    creVec (Finsupp.single k (1 : ℂ)) w = creA k w := by sorry
