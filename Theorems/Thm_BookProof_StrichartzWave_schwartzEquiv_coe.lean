-- Generated from ChapterStrichartzWave.lean — theorem BookProof.StrichartzWave.schwartzEquiv_coe
import Mathlib
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_BookProof.ChapterClosureUniqueness

open BookProof.StrichartzWave










open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

theorem BookProof.StrichartzWave.schwartzEquiv_coe (f : 𝓢(V, ℂ)) :
    ((schwartzEquiv V f : schwartzDomain V) : Lp ℂ 2 (volume : Measure V))
      = f.toLp 2 (volume : Measure V) := by sorry
