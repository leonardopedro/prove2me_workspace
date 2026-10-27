-- Generated from ChapterNsFieldMomentumInverse.lean — solution of BookProof.NsFieldMomentumInverse.isMomInverse_smul
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
theorem solution {m : W} (c : ℂ) {f g : Lp ℂ 2 (volume : Measure W)}
    (h : IsMomInverse m f g) : IsMomInverse m (c • f) (c • g) := by

  filter_upwards [h, MeasureTheory.Lp.coeFn_smul c g, MeasureTheory.Lp.coeFn_smul c f]
    with ξ hx hg hf
  rw [hg, hf]
  simp only [Pi.smul_apply, smul_eq_mul]
  rw [← mul_assoc, mul_comm _ c, mul_assoc, hx]
