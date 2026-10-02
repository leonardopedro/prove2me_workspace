-- Generated from ChapterStrichartzWave.lean — solution of BookProof.StrichartzWave.schwartzEquiv_coe
import Mathlib
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

set_option maxHeartbeats 1000000 in
 exact congrArg (fun y => (T y).toLp 2 (volume : Measure V))
    (LinearEquiv.symm_apply_apply (schwartzEquiv V) f)

theorem solution (f : 𝓢(V, ℂ)) :=
  :
