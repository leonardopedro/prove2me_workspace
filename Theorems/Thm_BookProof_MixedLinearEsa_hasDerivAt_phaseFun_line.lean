-- Generated from ChapterMixedLinearEsa.lean — theorem BookProof.MixedLinearEsa.hasDerivAt_phaseFun_line
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


theorem BookProof.MixedLinearEsa.hasDerivAt_phaseFun_line {W θ : V → ℝ} {m : V}
    (hθd : ∀ x, HasDerivAt (fun t : ℝ => θ (x + t • m)) (-(W x)) 0) (x : V) :
    HasDerivAt (fun t : ℝ => phaseFun θ (x + t • m))
      (phaseFun θ x * (Complex.I * ((-(W x) : ℝ) : ℂ))) 0 := by sorry
