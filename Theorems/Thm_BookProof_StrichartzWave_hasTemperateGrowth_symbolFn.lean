-- Generated from ChapterWaveUnboundedPotential.lean — theorem BookProof.StrichartzWave.hasTemperateGrowth_symbolFn
import Mathlib
import Definitions.Def_ChapterWaveUnboundedPotential
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {ι : Type*} [Fintype ι]

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
theorem BookProof.StrichartzWave.hasTemperateGrowth_symbolFn (c : ι → ℝ) (w : ι → V) (κ : ℝ) :
    Function.HasTemperateGrowth (symbolFn c w κ) := by sorry
