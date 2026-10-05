-- Generated from ChapterFockCubicQuarticStability.lean — theorem BookProof.FockCubicQuarticStability.norm_creA_sq
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockFieldPerturbation
import Definitions.Def_ChapterFockCubicUnbounded
import Mathlib
import Definitions.Def_ChapterFockCubicQuarticStability
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization
open BookProof.FockCubicQuarticStability


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicUnbounded

theorem BookProof.FockCubicQuarticStability.norm_creA_sq (k : ℕ) (v : FockAlg) :
    ‖toLp (creA k v)‖ ^ 2 = ‖toLp (annA k v)‖ ^ 2 + ‖toLp v‖ ^ 2 := by sorry
