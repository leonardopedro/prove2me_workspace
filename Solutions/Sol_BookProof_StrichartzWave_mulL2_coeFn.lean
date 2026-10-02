-- Generated from ChapterWaveBoundedPotential.lean — solution of BookProof.StrichartzWave.mulL2_coeFn
import Mathlib
import Definitions.Def_ChapterWaveBoundedPotential
open BookProof.StrichartzWave




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (W : Lp ℂ (⊤ : ℝ≥0∞) (volume : Measure V))
    (u : Lp ℂ 2 (volume : Measure V)) :
    (mulL2 W u : V → ℂ) =ᵐ[(volume : Measure V)] fun x => (W x) * (u x) := ContinuousLinearMap.coeFn_holder _ _ _
