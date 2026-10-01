-- Generated from ChapterWaveBoundedPotential.lean — solution of BookProof.StrichartzWave.wave_add_boundedPotential_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterWaveBoundedPotential
import Theorems.Thm_BookProof_StrichartzWave_mulL2_symmetric
import Theorems.Thm_BookProof_KatoRellich_essentiallySelfAdjointOn_add_bounded
import Theorems.Thm_BookProof_StrichartzWave_wave_essentiallySelfAdjoint
import Theorems.Thm_BookProof_StrichartzWave_wave_symmetric
open BookProof.StrichartzWave




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ)
    (W : Lp ℂ (⊤ : ℝ≥0∞) (volume : Measure (SpaceTime n)))
    (hW : ∀ᵐ x ∂(volume : Measure (SpaceTime n)), (starRingEnd ℂ) (W x) = W x) :
    BookProof.FarisLavine.EssentiallySelfAdjointOn (schwartzDomain (SpaceTime n))
      (opL2 (waveOp n 0) +
        ((mulL2 W).toLinearMap ∘ₗ (schwartzDomain (SpaceTime n)).subtype)) :=
  BookProof.KatoRellich.essentiallySelfAdjointOn_add_bounded _ (wave_symmetric n 0)
      (wave_essentiallySelfAdjoint n 0) (mulL2 W) (mulL2_symmetric W hW)
