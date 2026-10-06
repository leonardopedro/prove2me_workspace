-- Generated from ChapterFourierMultiplierEsa.lean — theorem BookProof.FourierMultiplierEsa.fourier_momentumOp_apply
import Definitions.Def_ChapterStrichartzWave
import Mathlib
import Definitions.Def_ChapterFourierMultiplierEsa
open BookProof.FourierMultiplierEsa

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave


theorem BookProof.FourierMultiplierEsa.fourier_momentumOp_apply (f : 𝓢(V, ℂ)) (m : V) (x : V) :
    (𝓕 (momentumOp m f) : 𝓢(V, ℂ)) x
      = ((2 * Real.pi * (inner ℝ x m) : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x := by sorry
