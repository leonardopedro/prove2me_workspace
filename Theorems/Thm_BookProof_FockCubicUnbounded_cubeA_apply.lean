-- Generated from ChapterFockCubicUnbounded.lean — theorem BookProof.FockCubicUnbounded.cubeA_apply
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockFieldPerturbation
import Mathlib
import Definitions.Def_ChapterFockCubicUnbounded
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization
open BookProof.FockCubicUnbounded


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation

theorem BookProof.FockCubicUnbounded.cubeA_apply (k : ℕ) (x : FockAlg) :
    cubeA k x = creA k (creA k (creA k x)) + annA k (annA k (annA k x)) := by sorry
