-- Generated from ChapterNsSpatialMomentumMultiplier.lean — solution of BookProof.NsSpatialMultiplier.mulSymbolOp_apply
import Mathlib
import Definitions.Def_ChapterNsSpatialMomentumMultiplier
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
theorem solution (σ : V → ℝ)
    (hσ : Function.HasTemperateGrowth (fun x : V => ((σ x : ℝ) : ℂ)))
    (f : 𝓢(V, ℂ)) (x : V) :
    (mulSymbolOp σ f : 𝓢(V, ℂ)) x = ((σ x : ℝ) : ℂ) * f x := by

  simp [mulSymbolOp, smulLeftCLM_apply hσ]
