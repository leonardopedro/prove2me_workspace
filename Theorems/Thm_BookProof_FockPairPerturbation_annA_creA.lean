-- Generated from ChapterFockPairPerturbation.lean — theorem BookProof.FockPairPerturbation.annA_creA
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

theorem BookProof.FockPairPerturbation.annA_creA (i j : ℕ) (u : FockAlg) :
    annA i (creA j u) = creA j (annA i u) + (if i = j then u else 0) := by sorry
