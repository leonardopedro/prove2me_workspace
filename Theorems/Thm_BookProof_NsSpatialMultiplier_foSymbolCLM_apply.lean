-- Generated from ChapterNsSpatialMomentumMultiplier.lean — theorem BookProof.NsSpatialMultiplier.foSymbolCLM_apply
import Definitions.Def_ChapterStrichartzWave
import Mathlib
import Definitions.Def_ChapterNsSpatialMomentumMultiplier
import Definitions.Def_ChapterFourierMultiplierEsa
open BookProof.FourierMultiplierEsa
open BookProof.NsSpatialMultiplier



open MeasureTheory SchwartzMap FourierTransform
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa

noncomputable section

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

variable (V) in

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
theorem BookProof.NsSpatialMultiplier.foSymbolCLM_apply (c : ι → ℝ) (w : ι → V) (x : V) :
    foSymbolCLM c w x = foSymbolFn c w x := by sorry
