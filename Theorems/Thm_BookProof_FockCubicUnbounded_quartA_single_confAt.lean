-- Generated from ChapterFockCubicUnbounded.lean — theorem BookProof.FockCubicUnbounded.quartA_single_confAt
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

theorem BookProof.FockCubicUnbounded.quartA_single_confAt (k m : ℕ) (z : ℂ) :
    quartA k (Finsupp.single (confAt k m) z)
      = Finsupp.single (confAt k m) ((((m : ℝ) * ((m : ℝ) - 1) : ℝ) : ℂ) * z) := by sorry
