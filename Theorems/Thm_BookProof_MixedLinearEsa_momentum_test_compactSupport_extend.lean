-- Generated from ChapterMixedLinearEsa.lean — theorem BookProof.MixedLinearEsa.momentum_test_compactSupport_extend
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Definitions.Def_ChapterFourierMultiplierEsa
open BookProof.FourierMultiplierEsa
open BookProof.MixedLinearEsa



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]


theorem BookProof.MixedLinearEsa.momentum_test_compactSupport_extend (m : V) (z : ℂ) (w : Lp ℂ 2 (volume : Measure V))
    (hw : ∀ φ : 𝓢(V, ℂ), HasCompactSupport (φ : V → ℂ) →
      ∫ x, (starRingEnd ℂ) ((momentumOp m φ) x) * (w x)
        = z * ∫ x, (starRingEnd ℂ) (φ x) * (w x))
    (f : 𝓢(V, ℂ)) :
    ∫ x, (starRingEnd ℂ) ((momentumOp m f) x) * (w x)
      = z * ∫ x, (starRingEnd ℂ) (f x) * (w x) := by sorry
