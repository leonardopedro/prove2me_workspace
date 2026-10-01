-- Generated from ChapterStrichartzWave.lean — theorem BookProof.StrichartzWave.integrable_conj_schwartz_mul
import Mathlib
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv


?_
  filter_upwards [f.coeFn_toLp 2 (volume : Measure V)] with x hx
  rw [hx]
  simp [RCLike.inner_apply, mul_comm]

theorem BookProof.StrichartzWave.integrable_conj_schwartz_mul (f : 𝓢(V, ℂ)) := by sorry
