-- Generated from ChapterMixedLinearEsa.lean — theorem BookProof.MixedLinearEsa.norm_gaugeFun
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterFourierMultiplierEsa
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
open BookProof.MixedLinearEsa



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]


theorem BookProof.MixedLinearEsa.norm_gaugeFun (b m : V) (x : V) : ‖gaugeFun b m x‖ = 1 := by sorry
