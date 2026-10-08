-- Generated from ChapterMixedLinearEsa.lean — theorem BookProof.MixedLinearEsa.contDiff_polyPhase
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterFourierMultiplierEsa
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
open BookProof.MixedLinearEsa



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]


omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
theorem BookProof.MixedLinearEsa.contDiff_polyPhase (c : ℕ → ℝ) (n : ℕ) (m : V) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (polyPhase c n m) := by sorry
