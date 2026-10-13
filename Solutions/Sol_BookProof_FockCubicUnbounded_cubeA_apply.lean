-- Generated from ChapterFockCubicUnbounded.lean — solution of BookProof.FockCubicUnbounded.cubeA_apply
import Mathlib
import Definitions.Def_ChapterFockCubicUnbounded
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockFieldPerturbation
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockCubicUnbounded



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockSecondQuantization

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (x : FockAlg) :
    cubeA k x = creA k (creA k (creA k x)) + annA k (annA k (annA k x)) := rfl
