-- Generated from ChapterWaveUnboundedPotential.lean — theorem BookProof.StrichartzWave.multiplierOp_apply_eq
import Mathlib
import Definitions.Def_ChapterWaveUnboundedPotential
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal


theorem BookProof.StrichartzWave.multiplierOp_apply_eq (m : V → ℝ) (f : 𝓢(V, ℂ)) :
    (multiplierOp m f : 𝓢(V, ℂ)) = 𝓕⁻ (potentialOp m (𝓕 f : 𝓢(V, ℂ))) := by sorry
