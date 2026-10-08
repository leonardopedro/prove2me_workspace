-- Generated from ChapterMixedLinearEsa.lean — theorem BookProof.MixedLinearEsa.momentumOp_eq_zero_of_compactSupport_test
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Definitions.Def_ChapterFourierMultiplierEsa
import Definitions.Def_ChapterStrichartzWave
open BookProof.FourierMultiplierEsa
open BookProof.StrichartzWave
open BookProof.MixedLinearEsa



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]


theorem BookProof.MixedLinearEsa.momentumOp_eq_zero_of_compactSupport_test (m : V) {z : ℂ} (hz : z.im ≠ 0)
    (w : Lp ℂ 2 (volume : Measure V))
    (hw : ∀ φ : 𝓢(V, ℂ), HasCompactSupport (φ : V → ℂ) →
      ∫ x, (starRingEnd ℂ) ((momentumOp m φ) x) * (w x)
        = z * ∫ x, (starRingEnd ℂ) (φ x) * (w x)) :
    w = 0 := by sorry
