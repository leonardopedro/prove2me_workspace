-- Generated from ChapterMixedLinearEsa.lean — theorem BookProof.MixedLinearEsa.mixedLinearOp_gauge
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


theorem BookProof.MixedLinearEsa.mixedLinearOp_gauge (b m : V) (hm : m ≠ 0) (φ : 𝓢(V, ℂ))
    (hφ : HasCompactSupport (φ : V → ℂ)) (x : V) :
    (mixedLinearOp b m (gaugeSchwartz b m φ hφ)) x
      = gaugeFun b m x * (momentumOp m φ x) := by sorry
