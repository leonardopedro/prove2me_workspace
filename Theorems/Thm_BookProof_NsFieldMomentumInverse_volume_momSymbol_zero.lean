-- Generated from ChapterNsFieldMomentumInverse.lean — theorem BookProof.NsFieldMomentumInverse.volume_momSymbol_zero
import Definitions.Def_ChapterNsSpatialMomentumMultiplier
import Definitions.Def_ChapterFourierMultiplierEsa
import Definitions.Def_ChapterStrichartzWave
import Mathlib
import Definitions.Def_ChapterNsFieldMomentumInverse
open BookProof.NsFieldMomentumInverse

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [FiniteDimensional ℝ W]
  [MeasurableSpace W] [BorelSpace W]



open MeasureTheory SchwartzMap FourierTransform
open BookProof.NsSpatialMultiplier BookProof.FourierMultiplierEsa BookProof.StrichartzWave

noncomputable section


theorem BookProof.NsFieldMomentumInverse.volume_momSymbol_zero {m : W} (hm : m ≠ 0) :
    (volume : Measure W) {ξ : W | momSymbol m ξ = 0} = 0 := by sorry
