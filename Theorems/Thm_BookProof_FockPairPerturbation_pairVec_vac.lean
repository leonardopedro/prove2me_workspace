-- Generated from ChapterFockPairPerturbation.lean — theorem BookProof.FockPairPerturbation.pairVec_vac
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterA4
open BookProof.FockOneParticleGap
open BookProof.FockSecondQuantization
open BookProof.FockPairPerturbation

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockFieldPerturbation

theorem BookProof.FockPairPerturbation.pairVec_vac (k : ℕ) :
    pairVec (Finsupp.single k 1) (Finsupp.single k 1) vac
      = Finsupp.single (Finsupp.single k 2) ((Real.sqrt 2 : ℝ) : ℂ) := by sorry
