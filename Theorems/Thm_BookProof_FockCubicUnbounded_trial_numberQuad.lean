-- Generated from ChapterFockCubicUnbounded.lean — theorem BookProof.FockCubicUnbounded.trial_numberQuad
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockFieldPerturbation
import Mathlib
import Definitions.Def_ChapterFockCubicUnbounded
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterTempleSeparationNecessary
open BookProof.FockOneParticleGap
open BookProof.FockSecondQuantization
open BookProof.TempleSeparationNecessary
open BookProof.FockCubicUnbounded


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation

theorem BookProof.FockCubicUnbounded.trial_numberQuad (k n : ℕ) (c : ℝ) :
    numberQuad (trial k n c) = (n : ℝ) + ((n : ℝ) + 3) * c ^ 2 := by sorry
