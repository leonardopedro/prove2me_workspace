-- Generated from ChapterMixedLinearEsa.lean — solution of BookProof.MixedLinearEsa.hasTemperateGrowth_polyPotential
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
open BookProof.MixedLinearEsa




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in
omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
theorem solution (c : ℕ → ℝ) (n : ℕ) (m : V) :
    Function.HasTemperateGrowth (polyPotential c n m) := by

  unfold polyPotential
  refine Function.HasTemperateGrowth.sum fun i _ => ?_
  exact (Function.HasTemperateGrowth.const (c i)).mul
    ((Function.hasTemperateGrowth_inner_left m).pow i)
