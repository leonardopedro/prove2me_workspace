-- Generated from ChapterWaveUnboundedPotential.lean — solution of BookProof.StrichartzWave.fourier_multiplierOp_apply
import Mathlib
import Definitions.Def_ChapterWaveUnboundedPotential
import Theorems.Thm_BookProof_StrichartzWave_multiplierOp_apply_eq
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]


private lemma hasTemperateGrowth_ofReal {W : V → ℝ} (hW : Function.HasTemperateGrowth W) :
    Function.HasTemperateGrowth (fun x => (W x : ℂ)) := by
  exact Function.HasTemperateGrowth.comp Complex.ofRealCLM.hasTemperateGrowth hW

@[simp] private theorem potentialOp_apply {W : V → ℝ} (hW : Function.HasTemperateGrowth W)
    (f : 𝓢(V, ℂ)) (x : V) : potentialOp W f x = (W x : ℂ) * f x := by
  simp [potentialOp, SchwartzMap.smulLeftCLM_apply_apply (hasTemperateGrowth_ofReal hW)]

set_option maxHeartbeats 1000000 in

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
theorem solution {m : V → ℝ} (hm : Function.HasTemperateGrowth m)
    (f : 𝓢(V, ℂ)) (x : V) :
    (𝓕 (multiplierOp m f) : 𝓢(V, ℂ)) x = ((m x : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x := by
  rw [multiplierOp_apply_eq, fourier_fourierInv_eq, potentialOp_apply hm]
