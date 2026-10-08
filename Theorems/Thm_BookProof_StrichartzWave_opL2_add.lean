-- Generated from ChapterWaveUnboundedPotential.lean — theorem BookProof.StrichartzWave.opL2_add
import Mathlib
import Definitions.Def_ChapterWaveUnboundedPotential
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]


theorem BookProof.StrichartzWave.opL2_add (T S : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ)) : opL2 (T + S) = opL2 T + opL2 S := by sorry
