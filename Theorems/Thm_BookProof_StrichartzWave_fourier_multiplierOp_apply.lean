-- Generated from ChapterWaveUnboundedPotential.lean — theorem BookProof.StrichartzWave.fourier_multiplierOp_apply
import Mathlib
import Definitions.Def_ChapterWaveUnboundedPotential
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal


theorem BookProof.StrichartzWave.fourier_multiplierOp_apply {m : V → ℝ} (hm : Function.HasTemperateGrowth m)
    (f : 𝓢(V, ℂ)) (x : V) :
    (𝓕 (multiplierOp m f) : 𝓢(V, ℂ)) x = ((m x : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x := by sorry
