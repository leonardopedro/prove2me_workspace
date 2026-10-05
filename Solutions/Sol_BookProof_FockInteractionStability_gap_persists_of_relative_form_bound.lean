-- Generated from ChapterFockInteractionStability.lean — solution of BookProof.FockInteractionStability.gap_persists_of_relative_form_bound
import Mathlib
import Definitions.Def_ChapterFockInteractionStability
open BookProof.FockInteractionStability



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap
open BookProof.FarisLavine BookProof.NavierStokesFlow



variable {E : Type*} [NormedAddCommGroup E]

variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution
    {q v : E → ℝ} {S : Set E} {mu a b : ℝ} (ha : a ≤ 1)
    (hq : ∀ x ∈ S, mu * ‖x‖ ^ 2 ≤ q x)
    (hv : ∀ x, |v x| ≤ a * q x + b * ‖x‖ ^ 2) :
    ∀ x ∈ S, ((1 - a) * mu - b) * ‖x‖ ^ 2 ≤ q x + v x := by

  intro x hx
  have h1 : mu * ‖x‖ ^ 2 ≤ q x := hq x hx
  have h2 : -(a * q x + b * ‖x‖ ^ 2) ≤ v x := (abs_le.mp (hv x)).1
  have h3 : 0 ≤ (1 - a) * (q x - mu * ‖x‖ ^ 2) :=
    mul_nonneg (by linarith) (by linarith)
  nlinarith
