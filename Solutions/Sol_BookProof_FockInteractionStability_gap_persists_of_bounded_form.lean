-- Generated from ChapterFockInteractionStability.lean — solution of BookProof.FockInteractionStability.gap_persists_of_bounded_form
import Mathlib
import Definitions.Def_ChapterFockInteractionStability
import Theorems.Thm_BookProof_FockInteractionStability_gap_persists_of_relative_form_bound
open BookProof.FockInteractionStability



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap
open BookProof.FarisLavine BookProof.NavierStokesFlow



variable {E : Type*} [NormedAddCommGroup E]

variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution
    {q v : E → ℝ} {S : Set E} {mu b : ℝ}
    (hq : ∀ x ∈ S, mu * ‖x‖ ^ 2 ≤ q x)
    (hv : ∀ x, |v x| ≤ b * ‖x‖ ^ 2) :
    ∀ x ∈ S, (mu - b) * ‖x‖ ^ 2 ≤ q x + v x := by

  have h := gap_persists_of_relative_form_bound (q := q) (v := v) (S := S) (mu := mu)
    (a := 0) (b := b) zero_le_one hq (by simpa using hv)
  intro x hx
  have := h x hx
  simpa using this
