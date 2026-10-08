-- Generated from ChapterFourierMultiplierEsa.lean — theorem BookProof.FourierMultiplierEsa.contDiff_foSymbolFn
import Definitions.Def_ChapterStrichartzWave
import Mathlib
import Definitions.Def_ChapterFourierMultiplierEsa
open BookProof.FourierMultiplierEsa



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]


omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
theorem BookProof.FourierMultiplierEsa.contDiff_foSymbolFn (c : ι → ℝ) (w : ι → V) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (foSymbolFn c w) := by sorry
