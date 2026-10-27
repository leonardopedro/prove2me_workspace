-- Generated from ChapterSolovaySeparableExistence.lean — solution of BookProof.ChapterSolovaySeparableExistence.joint_prob_has_wavefunction_prod
import Mathlib
import Definitions.Def_ChapterSolovaySeparableExistence
import Theorems.Thm_BookProof_ChapterSolovaySeparableExistence_joint_prob_has_wavefunction
open BookProof.ChapterSolovaySeparableExistence



noncomputable section

open MeasureTheory ProbabilityTheory


open BookProof.ChapterSolovayCoordinates

set_option maxHeartbeats 1000000 in
theorem solution {X Y : Type*} [Fintype X] [Fintype Y]
    (p : X × Y → ℝ) (hp : ∀ z, 0 ≤ p z) (hsum : ∑ z, p z = 1) :
    ∃ Ψ : X × Y → ℂ, (∀ z, ‖Ψ z‖ ^ 2 = p z) ∧ ∑ z, ‖Ψ z‖ ^ 2 = 1 ∧
      ∀ x : X, (∑ y : Y, ‖Ψ (x, y)‖ ^ 2) = ∑ y : Y, p (x, y) := by

  obtain ⟨Ψ, hΨ, hΨsum⟩ := joint_prob_has_wavefunction p hp hsum
  exact ⟨Ψ, hΨ, hΨsum, fun x => Finset.sum_congr rfl fun y _ => hΨ (x, y)⟩
