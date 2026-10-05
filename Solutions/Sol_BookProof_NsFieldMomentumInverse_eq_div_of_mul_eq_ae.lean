-- Generated from ChapterNsFieldMomentumInverse.lean — solution of BookProof.NsFieldMomentumInverse.eq_div_of_mul_eq_ae
import Mathlib
import Definitions.Def_ChapterNsFieldMomentumInverse
import Theorems.Thm_BookProof_NsFieldMomentumInverse_momSymbol_ne_zero_ae
open BookProof.NsFieldMomentumInverse




open MeasureTheory SchwartzMap FourierTransform
open BookProof.NsSpatialMultiplier BookProof.FourierMultiplierEsa BookProof.StrichartzWave

noncomputable section

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [FiniteDimensional ℝ W]
  [MeasurableSpace W] [BorelSpace W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [FiniteDimensional ℝ W]
  [MeasurableSpace W] [BorelSpace W]

set_option maxHeartbeats 1000000 in
theorem solution {m : W} (hm : m ≠ 0) (t : W → ℂ) (p : ℂ)
    (h : ∀ᵐ ξ ∂(volume : Measure W), ((momSymbol m ξ : ℝ) : ℂ) * t ξ = p) :
    ∀ᵐ ξ ∂(volume : Measure W), t ξ = p / ((momSymbol m ξ : ℝ) : ℂ) := by

  filter_upwards [h, momSymbol_ne_zero_ae hm] with ξ hξ hσ
  have hσ' : ((momSymbol m ξ : ℝ) : ℂ) ≠ 0 := by simpa using hσ
  rw [eq_div_iff hσ', mul_comm]
  exact hξ
