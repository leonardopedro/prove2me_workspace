-- Generated from ChapterMixedLinearEsa.lean — solution of BookProof.MixedLinearEsa.mixedLinearOp_apply
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Theorems.Thm_BookProof_MixedLinearEsa_momentumOp_apply
open BookProof.MixedLinearEsa




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in
omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
theorem solution (b m : V) (f : 𝓢(V, ℂ)) (x : V) :
    (mixedLinearOp b m f) x
      = ((inner ℝ x b : ℝ) : ℂ) * f x + (-Complex.I) * (fderiv ℝ f x m) := by

  simp [mixedLinearOp, momentumOp_apply]
