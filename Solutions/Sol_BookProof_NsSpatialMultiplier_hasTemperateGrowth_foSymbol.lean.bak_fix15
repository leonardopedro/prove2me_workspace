-- Generated from ChapterNsSpatialMomentumMultiplier.lean — solution of BookProof.NsSpatialMultiplier.hasTemperateGrowth_foSymbol
import Mathlib
import Definitions.Def_ChapterNsSpatialMomentumMultiplier
import Theorems.Thm_BookProof_NsSpatialMultiplier_foSymbolCLM_apply
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
omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
theorem solution (c : ι → ℝ) (w : ι → V) :
    Function.HasTemperateGrowth (fun x : V => ((foSymbolFn c w x : ℝ) : ℂ)) := by

  have h : (fun x : V => ((foSymbolFn c w x : ℝ) : ℂ))
      = fun x => (Complex.ofRealCLM.comp (foSymbolCLM c w)) x := by
    funext x
    simp [foSymbolCLM_apply]
  rw [h]
  exact ContinuousLinearMap.hasTemperateGrowth _
