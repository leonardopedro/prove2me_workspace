-- Generated from ChapterStrichartzWave.lean — theorem BookProof.StrichartzWave.exists_smooth_cutoff
import Mathlib
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave










open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

omit [MeasurableSpace V] [BorelSpace V] in
theorem BookProof.StrichartzWave.exists_smooth_cutoff (R : ℝ) :
    ∃ χ : V → ℝ, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) χ ∧ HasCompactSupport χ ∧
      (∀ x, ‖x‖ ≤ R → χ x = 1) ∧ (∀ x, χ x ∈ Set.Icc (0 : ℝ) 1) ∧
      (∀ x, R + 1 ≤ ‖x‖ → χ x = 0) ∧ ∃ C : ℝ, ∀ x, ‖gradient χ x‖ ≤ C := by sorry
