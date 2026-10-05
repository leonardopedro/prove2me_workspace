-- Generated from ChapterNsFieldMomentumInverse.lean — solution of BookProof.NsFieldMomentumInverse.coeFn_cut
import Mathlib
import Definitions.Def_ChapterNsFieldMomentumInverse
open BookProof.NsFieldMomentumInverse




open MeasureTheory SchwartzMap FourierTransform
open BookProof.NsSpatialMultiplier BookProof.FourierMultiplierEsa BookProof.StrichartzWave

noncomputable section

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [FiniteDimensional ℝ W]
  [MeasurableSpace W] [BorelSpace W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [FiniteDimensional ℝ W]
  [MeasurableSpace W] [BorelSpace W]

set_option maxHeartbeats 1000000 in
theorem solution (m : W) (n : ℕ) (f : Lp ℂ 2 (volume : Measure W)) :
    (cut m n f : W → ℂ) =ᵐ[(volume : Measure W)] (cutSet m n).indicator (f : W → ℂ) := ((MeasureTheory.Lp.memLp f).indicator (measurableSet_cutSet m n)).coeFn_toLp
