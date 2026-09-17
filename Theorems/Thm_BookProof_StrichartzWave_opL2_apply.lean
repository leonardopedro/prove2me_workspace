-- Generated from ChapterStrichartzWave.lean — theorem BookProof.StrichartzWave.opL2_apply
import Mathlib
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave










open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

theorem BookProof.StrichartzWave.opL2_apply (T : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ)) (f : 𝓢(V, ℂ)) :
    opL2 T (schwartzEquiv V f) = (T f).toLp 2 (volume : Measure V) := by sorry
