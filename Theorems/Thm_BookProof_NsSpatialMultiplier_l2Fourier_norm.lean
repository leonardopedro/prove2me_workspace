-- Generated from ChapterNsSpatialMomentumMultiplier.lean — theorem BookProof.NsSpatialMultiplier.l2Fourier_norm
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterFourierMultiplierEsa
import Mathlib
import Definitions.Def_ChapterNsSpatialMomentumMultiplier
open BookProof.NsSpatialMultiplier

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]
variable (V) in



open MeasureTheory SchwartzMap FourierTransform
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa

noncomputable section


theorem BookProof.NsSpatialMultiplier.l2Fourier_norm (v : Lp ℂ 2 (volume : Measure V)) : ‖l2Fourier V v‖ = ‖v‖ := by sorry
