-- Generated from ChapterWaveBoundedPotential.lean — theorem BookProof.StrichartzWave.mulL2_symmetric
import Mathlib
import Definitions.Def_ChapterWaveBoundedPotential
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal


theorem BookProof.StrichartzWave.mulL2_symmetric (W : Lp ℂ (⊤ : ℝ≥0∞) (volume : Measure V))
    (hW : ∀ᵐ x ∂(volume : Measure V), (starRingEnd ℂ) (W x) = W x)
    (u w : Lp ℂ 2 (volume : Measure V)) :
    (inner ℂ (mulL2 W u) w : ℂ) = inner ℂ u (mulL2 W w) := by sorry
