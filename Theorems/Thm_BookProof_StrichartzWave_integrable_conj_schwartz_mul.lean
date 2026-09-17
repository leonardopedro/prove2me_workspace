-- Generated from ChapterStrichartzWave.lean — theorem BookProof.StrichartzWave.integrable_conj_schwartz_mul
import Mathlib
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave










open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

theorem BookProof.StrichartzWave.integrable_conj_schwartz_mul (f : 𝓢(V, ℂ)) (u : Lp ℂ 2 (volume : Measure V)) :
    Integrable (fun x => (starRingEnd ℂ) (f x) * (u x)) (volume : Measure V) := by sorry
