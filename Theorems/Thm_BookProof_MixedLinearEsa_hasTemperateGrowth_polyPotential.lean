-- Generated from ChapterMixedLinearEsa.lean — theorem BookProof.MixedLinearEsa.hasTemperateGrowth_polyPotential
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterFourierMultiplierEsa
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
open BookProof.MixedLinearEsa

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine


omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
theorem BookProof.MixedLinearEsa.hasTemperateGrowth_polyPotential (c : ℕ → ℝ) (n : ℕ) (m : V) :
    Function.HasTemperateGrowth (polyPotential c n m) := by sorry
