-- Generated from ChapterNsSpatialMomentumMultiplier.lean — theorem BookProof.NsSpatialMultiplier.foSymbolFn_congr_of_inner_eq
import Definitions.Def_ChapterStrichartzWave
import Mathlib
import Definitions.Def_ChapterNsSpatialMomentumMultiplier
import Definitions.Def_ChapterFourierMultiplierEsa
open BookProof.FourierMultiplierEsa
open BookProof.NsSpatialMultiplier

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]
variable (V) in



open MeasureTheory SchwartzMap FourierTransform
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa

noncomputable section


theorem BookProof.NsSpatialMultiplier.foSymbolFn_congr_of_inner_eq (c : ι → ℝ) (w : ι → V) {x y : V}
    (h : ∀ i, (inner ℝ x (w i) : ℝ) = inner ℝ y (w i)) :
    foSymbolFn c w x = foSymbolFn c w y := by sorry
