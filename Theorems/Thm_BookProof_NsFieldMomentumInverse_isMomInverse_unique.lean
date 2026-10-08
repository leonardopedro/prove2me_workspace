-- Generated from ChapterNsFieldMomentumInverse.lean — theorem BookProof.NsFieldMomentumInverse.isMomInverse_unique
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


theorem BookProof.NsFieldMomentumInverse.isMomInverse_unique {m : W} (hm : m ≠ 0) {f g₁ g₂ : Lp ℂ 2 (volume : Measure W)}
    (h₁ : IsMomInverse m f g₁) (h₂ : IsMomInverse m f g₂) : g₁ = g₂ := by sorry
