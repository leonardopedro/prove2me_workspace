-- Generated from ChapterFockCubicUnbounded.lean — theorem BookProof.FockCubicUnbounded.fock_gap_fails_for_cubic
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

theorem BookProof.FockCubicUnbounded.fock_gap_fails_for_cubic (k : ℕ) {lam : ℝ} (hlam : 0 < lam) (M : ℝ) :
    ∃ u : FockAlg, u 0 = 0 ∧
      (inner ℂ (toLp u) (toLp (dGamma numberCol u)) : ℂ).re
          + lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
        ≤ -M * ‖toLp u‖ ^ 2 := by sorry
