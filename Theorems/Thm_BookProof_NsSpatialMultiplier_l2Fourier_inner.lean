-- Generated from ChapterNsSpatialMomentumMultiplier.lean — theorem BookProof.NsSpatialMultiplier.l2Fourier_inner
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterFourierMultiplierEsa
import Mathlib
import Definitions.Def_ChapterNsSpatialMomentumMultiplier
open BookProof.NsSpatialMultiplier



open MeasureTheory SchwartzMap FourierTransform
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa

noncomputable section

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

variable (V) in

theorem BookProof.NsSpatialMultiplier.l2Fourier_inner (v u : Lp ℂ 2 (volume : Measure V)) :
    (inner ℂ (l2Fourier V v) (l2Fourier V u) : ℂ) = inner ℂ v u := by sorry
