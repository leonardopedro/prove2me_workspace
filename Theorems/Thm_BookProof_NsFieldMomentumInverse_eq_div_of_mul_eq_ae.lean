-- Generated from ChapterNsFieldMomentumInverse.lean — theorem BookProof.NsFieldMomentumInverse.eq_div_of_mul_eq_ae
import Definitions.Def_ChapterNsSpatialMomentumMultiplier
import Definitions.Def_ChapterFourierMultiplierEsa
import Definitions.Def_ChapterStrichartzWave
import Mathlib
import Definitions.Def_ChapterNsFieldMomentumInverse
open BookProof.NsFieldMomentumInverse



open MeasureTheory SchwartzMap FourierTransform
open BookProof.NsSpatialMultiplier BookProof.FourierMultiplierEsa BookProof.StrichartzWave

noncomputable section

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [FiniteDimensional ℝ W]
  [MeasurableSpace W] [BorelSpace W]


theorem BookProof.NsFieldMomentumInverse.eq_div_of_mul_eq_ae {m : W} (hm : m ≠ 0) (t : W → ℂ) (p : ℂ)
    (h : ∀ᵐ ξ ∂(volume : Measure W), ((momSymbol m ξ : ℝ) : ℂ) * t ξ = p) :
    ∀ᵐ ξ ∂(volume : Measure W), t ξ = p / ((momSymbol m ξ : ℝ) : ℂ) := by sorry
