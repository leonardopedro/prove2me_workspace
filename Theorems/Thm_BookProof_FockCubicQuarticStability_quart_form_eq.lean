-- Generated from ChapterFockCubicQuarticStability.lean — theorem BookProof.FockCubicQuarticStability.quart_form_eq
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

theorem BookProof.FockCubicQuarticStability.quart_form_eq (k : ℕ) (u : FockAlg) :
    (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re = ‖toLp (annA k (annA k u))‖ ^ 2 := by sorry
