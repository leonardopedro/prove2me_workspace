-- Generated from ChapterMixedLinearEsa.lean — theorem BookProof.MixedLinearEsa.mixedLinearOp_apply
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Definitions.Def_ChapterFourierMultiplierEsa
open BookProof.FourierMultiplierEsa
open BookProof.MixedLinearEsa



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]


theorem BookProof.MixedLinearEsa.mixedLinearOp_apply (b m : V) (f : 𝓢(V, ℂ)) (x : V) :
    (mixedLinearOp b m f) x
      = ((inner ℝ x b : ℝ) : ℂ) * f x + (-Complex.I) * (fderiv ℝ f x m) := by sorry
