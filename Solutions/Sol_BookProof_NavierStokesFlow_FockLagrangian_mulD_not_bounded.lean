-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.mulD_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_norm_mulD_ge
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) {g h : X → ℝ} (hh : Measurable h)
    (hdom : DominatedOn μ g h)
    (H : ∀ K : ℝ, ∃ v : boundedEnergyCore μ g, ‖((v : Lp ℂ 2 μ))‖ = 1 ∧
      ∀ᵐ x ∂μ, ((v : Lp ℂ 2 μ) : X → ℂ) x ≠ 0 → K ≤ |h x|) :
    ¬ ∃ C : ℝ, ∀ v : boundedEnergyCore μ g,
      ‖((mulD μ hh hdom v : boundedEnergyCore μ g) : Lp ℂ 2 μ)‖ ≤ C * ‖((v : Lp ℂ 2 μ))‖ := by

  rintro ⟨C, hC⟩
  obtain ⟨v, hv1, hvge⟩ := H (|C| + 1)
  have hlow := norm_mulD_ge μ hh hdom v (by positivity) hvge
  have hup := hC v
  rw [hv1, mul_one] at hlow hup
  have : |C| + 1 ≤ C := le_trans hlow hup
  have hCle : C ≤ |C| := le_abs_self C
  linarith
