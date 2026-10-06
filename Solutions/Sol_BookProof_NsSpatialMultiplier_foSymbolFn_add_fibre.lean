-- Generated from ChapterNsSpatialMomentumMultiplier.lean — solution of BookProof.NsSpatialMultiplier.foSymbolFn_add_fibre
import Mathlib
import Definitions.Def_ChapterNsSpatialMomentumMultiplier
import Theorems.Thm_BookProof_NsSpatialMultiplier_foSymbolFn_congr_of_inner_eq
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
theorem solution (c : ι → ℝ) (w : ι → V) (x m : V)
    (hm : ∀ i, (inner ℝ m (w i) : ℝ) = 0) (t : ℝ) :
    foSymbolFn c w (x + t • m) = foSymbolFn c w x := by

  refine foSymbolFn_congr_of_inner_eq c w fun i => ?_
  rw [inner_add_left, real_inner_smul_left, hm i, mul_zero, add_zero]
