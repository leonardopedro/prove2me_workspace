-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.DominatedOn.mul
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
open BookProof.NavierStokesFlow



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
theorem solution {μ : Measure X} {g h₁ h₂ : X → ℝ} (d₁ : DominatedOn μ g h₁)
    (d₂ : DominatedOn μ g h₂) : DominatedOn μ g (fun x => h₁ x * h₂ x) := by

  intro n
  obtain ⟨M₁, hM₁, hx₁⟩ := d₁ n
  obtain ⟨M₂, hM₂, hx₂⟩ := d₂ n
  refine ⟨M₁ * M₂, mul_nonneg hM₁ hM₂, ?_⟩
  filter_upwards [hx₁, hx₂] with x h1 h2 hb
  rw [abs_mul]
  exact mul_le_mul (h1 hb) (h2 hb) (abs_nonneg _) hM₁
