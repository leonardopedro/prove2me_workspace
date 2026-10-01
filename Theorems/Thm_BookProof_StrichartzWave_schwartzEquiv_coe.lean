-- Generated from ChapterStrichartzWave.lean — theorem BookProof.StrichartzWave.schwartzEquiv_coe
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

 exact congrArg (fun y => (T y).toLp 2 (volume : Measure V))
    (LinearEquiv.symm_apply_apply (schwartzEquiv V) f)

theorem BookProof.StrichartzWave.schwartzEquiv_coe (f : 𝓢(V, ℂ)) := by sorry
