-- Generated from ChapterMixedLinearEsa.lean — theorem BookProof.MixedLinearEsa.exists_cutoff_seq
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterFourierMultiplierEsa
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
open BookProof.MixedLinearEsa

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine


theorem BookProof.MixedLinearEsa.exists_cutoff_seq :
    ∃ (cut : ℕ → V → ℝ) (K : ℝ),
      (∀ n, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (cut n)) ∧
      (∀ n, HasCompactSupport (cut n)) ∧
      (∀ n x, ‖cut n x‖ ≤ 1) ∧
      (∀ x : V, ∀ᶠ n in Filter.atTop, cut n x = 1 ∧ fderiv ℝ (cut n) x = 0) ∧
      (∀ n x, ‖fderiv ℝ (cut n) x‖ ≤ K) := by sorry
