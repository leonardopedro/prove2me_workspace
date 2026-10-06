-- Generated from ChapterFourierMultiplierEsa.lean — theorem BookProof.FourierMultiplierEsa.fourier_firstOrderOp_apply
import Definitions.Def_ChapterStrichartzWave
import Mathlib
import Definitions.Def_ChapterFourierMultiplierEsa
open BookProof.FourierMultiplierEsa

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave


theorem BookProof.FourierMultiplierEsa.fourier_firstOrderOp_apply (c : ι → ℝ) (w : ι → V) (f : 𝓢(V, ℂ)) (x : V) :
    (𝓕 (firstOrderOp c w f) : 𝓢(V, ℂ)) x
      = ((foSymbolFn c w x : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x := by sorry
