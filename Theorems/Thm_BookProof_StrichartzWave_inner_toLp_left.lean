-- Generated from ChapterStrichartzWave.lean — theorem BookProof.StrichartzWave.inner_toLp_left
import Mathlib
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

 Lp ℂ 2 (volume : Measure V))
      = f.toLp 2 (volume : Measure V) := rfl

theorem BookProof.StrichartzWave.inner_toLp_left (f : 𝓢(V, ℂ)) (u : Lp ℂ 2 (volume : := by sorry
