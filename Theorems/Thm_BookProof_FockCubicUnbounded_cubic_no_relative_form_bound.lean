-- Generated from ChapterFockCubicUnbounded.lean — theorem BookProof.FockCubicUnbounded.cubic_no_relative_form_bound
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockFieldPerturbation
import Mathlib
import Definitions.Def_ChapterFockCubicUnbounded
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterTempleSeparationNecessary
open BookProof.FockSecondQuantization
open BookProof.TempleSeparationNecessary
open BookProof.FockCubicUnbounded


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation

theorem BookProof.FockCubicUnbounded.cubic_no_relative_form_bound (k : ℕ) (a b : ℝ) :
    ∃ u : FockAlg, u 0 = 0 ∧
      a * numberQuad u + b * ‖toLp u‖ ^ 2
        < (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re := by sorry
