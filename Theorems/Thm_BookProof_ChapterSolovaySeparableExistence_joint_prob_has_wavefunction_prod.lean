-- Generated from ChapterSolovaySeparableExistence.lean — theorem BookProof.ChapterSolovaySeparableExistence.joint_prob_has_wavefunction_prod
import Definitions.Def_ChapterSolovayCoordinates
import Mathlib
import Definitions.Def_ChapterSolovaySeparableExistence
open BookProof.ChapterSolovaySeparableExistence


noncomputable section

open MeasureTheory ProbabilityTheory


open BookProof.ChapterSolovayCoordinates

theorem BookProof.ChapterSolovaySeparableExistence.joint_prob_has_wavefunction_prod {X Y : Type*} [Fintype X] [Fintype Y]
    (p : X × Y → ℝ) (hp : ∀ z, 0 ≤ p z) (hsum : ∑ z, p z = 1) :
    ∃ Ψ : X × Y → ℂ, (∀ z, ‖Ψ z‖ ^ 2 = p z) ∧ ∑ z, ‖Ψ z‖ ^ 2 = 1 ∧
      ∀ x : X, (∑ y : Y, ‖Ψ (x, y)‖ ^ 2) = ∑ y : Y, p (x, y) := by sorry
