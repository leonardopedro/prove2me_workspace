-- Generated from ChapterWaveUnboundedPotential.lean — solution of BookProof.StrichartzWave.opL2_add
import Mathlib
import Definitions.Def_ChapterWaveUnboundedPotential
open BookProof.StrichartzWave




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (T S : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ)) : opL2 (T + S) = opL2 T + opL2 S := LinearMap.ext fun v => by simp [opL2, map_add]
