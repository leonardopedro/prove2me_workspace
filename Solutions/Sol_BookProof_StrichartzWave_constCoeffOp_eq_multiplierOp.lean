-- Generated from ChapterWaveUnboundedPotential.lean — solution of BookProof.StrichartzWave.constCoeffOp_eq_multiplierOp
import Mathlib
import Definitions.Def_ChapterWaveUnboundedPotential
import Theorems.Thm_BookProof_StrichartzWave_fourier_multiplierOp_apply
import Theorems.Thm_BookProof_StrichartzWave_hasTemperateGrowth_symbolFn
import Theorems.Thm_BookProof_StrichartzWave_fourier_constCoeffOp_apply
open BookProof.StrichartzWave




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

set_option maxHeartbeats 1000000 in
theorem solution (c : ι → ℝ) (w : ι → V) (κ : ℝ) :
    constCoeffOp c w κ = multiplierOp (symbolFn c w κ) := by

  refine ContinuousLinearMap.ext fun f => ?_
  refine (FourierTransform.fourierCLE ℂ 𝓢(V, ℂ)).injective (SchwartzMap.ext fun x => ?_)
  change (𝓕 (constCoeffOp c w κ f) : 𝓢(V, ℂ)) x
    = (𝓕 (multiplierOp (symbolFn c w κ) f) : 𝓢(V, ℂ)) x
  rw [fourier_constCoeffOp_apply, fourier_multiplierOp_apply (hasTemperateGrowth_symbolFn c w κ)]
