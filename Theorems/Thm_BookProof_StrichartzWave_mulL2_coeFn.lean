-- Generated from ChapterWaveBoundedPotential.lean — theorem BookProof.StrichartzWave.mulL2_coeFn
import Mathlib
import Definitions.Def_ChapterWaveBoundedPotential
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal


theorem BookProof.StrichartzWave.mulL2_coeFn (W : Lp ℂ (⊤ : ℝ≥0∞) (volume : Measure V))
    (u : Lp ℂ 2 (volume : Measure V)) :
    (mulL2 W u : V → ℂ) =ᵐ[(volume : Measure V)] fun x => (W x) * (u x) := by sorry
