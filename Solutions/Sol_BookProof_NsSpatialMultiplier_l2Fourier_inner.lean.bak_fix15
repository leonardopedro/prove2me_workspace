-- Generated from ChapterNsSpatialMomentumMultiplier.lean — solution of BookProof.NsSpatialMultiplier.l2Fourier_inner
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
theorem solution (v u : Lp ℂ 2 (volume : Measure V)) :
    (inner ℂ (l2Fourier V v) (l2Fourier V u) : ℂ) = inner ℂ v u := (l2Fourier V).inner_map_map v u
