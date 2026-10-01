-- Generated from ChapterWaveBoundedPotential.lean — theorem BookProof.StrichartzWave.wave_add_boundedPotential_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterWaveBoundedPotential
open BookProof.StrichartzWave

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

theorem BookProof.StrichartzWave.wave_add_boundedPotential_essentiallySelfAdjoint (n : ℕ)
    (W : Lp ℂ (⊤ : ℝ≥0∞) (volume : Measure (SpaceTime n)))
    (hW : ∀ᵐ x ∂(volume : Measure (SpaceTime n)), (starRingEnd ℂ) (W x) = W x) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain (SpaceTime n))
      (opL2 (waveOp n 0) +
        ((mulL2 W).toLinearMap ∘ₗ (schwartzDomain (SpaceTime n)).subtype)) := by sorry
