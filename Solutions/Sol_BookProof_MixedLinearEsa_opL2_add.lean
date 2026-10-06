-- Generated from ChapterMixedLinearEsa.lean — solution of BookProof.MixedLinearEsa.opL2_add
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
theorem solution (A B : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ)) : opL2 (A + B) = opL2 A + opL2 B := by

  refine LinearMap.ext fun v => ?_
  simp only [opL2, LinearMap.coe_comp, Function.comp_apply, ContinuousLinearMap.coe_coe,
    ContinuousLinearMap.add_apply, LinearMap.add_apply, map_add]
