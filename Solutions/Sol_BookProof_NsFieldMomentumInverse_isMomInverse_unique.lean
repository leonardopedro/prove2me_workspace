-- Generated from ChapterNsFieldMomentumInverse.lean — solution of BookProof.NsFieldMomentumInverse.isMomInverse_unique
import Mathlib
import Definitions.Def_ChapterNsFieldMomentumInverse
import Theorems.Thm_BookProof_NsFieldMomentumInverse_momentum_kernel_trivial
open BookProof.NsFieldMomentumInverse




open MeasureTheory SchwartzMap FourierTransform
open BookProof.NsSpatialMultiplier BookProof.FourierMultiplierEsa BookProof.StrichartzWave

noncomputable section

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [FiniteDimensional ℝ W]
  [MeasurableSpace W] [BorelSpace W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [FiniteDimensional ℝ W]
  [MeasurableSpace W] [BorelSpace W]

set_option maxHeartbeats 1000000 in
theorem solution {m : W} (hm : m ≠ 0) {f g₁ g₂ : Lp ℂ 2 (volume : Measure W)}
    (h₁ : IsMomInverse m f g₁) (h₂ : IsMomInverse m f g₂) : g₁ = g₂ := by

  have h : IsMomInverse m 0 (g₁ - g₂) := by
    filter_upwards [h₁, h₂, MeasureTheory.Lp.coeFn_sub g₁ g₂,
      MeasureTheory.Lp.coeFn_zero (E := ℂ) (p := 2) (μ := (volume : Measure W))] with
      ξ hx₁ hx₂ hsub hz
    simp only [hsub, hz, Pi.sub_apply, Pi.zero_apply, mul_sub, hx₁, hx₂, sub_self]
  have := momentum_kernel_trivial hm _ h
  exact sub_eq_zero.mp this
