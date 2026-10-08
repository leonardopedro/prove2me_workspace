-- Generated from ChapterMixedLinearEsa.lean — theorem BookProof.MixedLinearEsa.hasDerivAt_gaugeFun_line
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


omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
theorem BookProof.MixedLinearEsa.hasDerivAt_gaugeFun_line (b m : V) (hm : m ≠ 0) (x : V) :
    HasDerivAt (fun t : ℝ => gaugeFun b m (x + t • m))
      (gaugeFun b m x * (Complex.I * ((-(inner ℝ x b : ℝ) : ℝ) : ℂ))) 0 := by sorry
