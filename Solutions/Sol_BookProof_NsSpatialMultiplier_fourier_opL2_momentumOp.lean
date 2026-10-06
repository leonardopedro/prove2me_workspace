-- Generated from ChapterNsSpatialMomentumMultiplier.lean — solution of BookProof.NsSpatialMultiplier.fourier_opL2_momentumOp
import Mathlib
import Definitions.Def_ChapterNsSpatialMomentumMultiplier
import Theorems.Thm_BookProof_NsSpatialMultiplier_fourier_opL2_eq_mulSymbol
import Theorems.Thm_BookProof_NsSpatialMultiplier_hasTemperateGrowth_foSymbol
import Theorems.Thm_BookProof_FourierMultiplierEsa_fourier_momentumOp_apply
open BookProof.NsSpatialMultiplier




open MeasureTheory SchwartzMap FourierTransform
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa

noncomputable section

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]
variable (V) in

set_option maxHeartbeats 1000000 in
theorem solution (m : V) (f : 𝓢(V, ℂ)) :
    l2Fourier V (opL2 (momentumOp m) (schwartzEquiv V f))
      = (mulSymbolOp (fun x => 2 * Real.pi * (inner ℝ x m : ℝ)) (𝓕 f)).toLp
          2 (volume : Measure V) := by

  have hσ : Function.HasTemperateGrowth
      (fun x : V => ((2 * Real.pi * (inner ℝ x m : ℝ) : ℝ) : ℂ)) := by
    have h := hasTemperateGrowth_foSymbol (fun _ : Fin 1 => (1 : ℝ)) (fun _ => m)
    simpa [foSymbolFn] using h
  refine fourier_opL2_eq_mulSymbol _ _ ?_ hσ f
  intro g x
  simpa using fourier_momentumOp_apply g m x
