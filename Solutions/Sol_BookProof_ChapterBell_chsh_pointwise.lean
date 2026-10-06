-- Generated from ChapterBell.lean — solution of BookProof.ChapterBell.chsh_pointwise
import Mathlib
import Definitions.Def_ChapterBell
open BookProof.ChapterBell



open scoped BigOperators
open MeasureTheory

set_option maxHeartbeats 1000000 in
theorem solution {a₀ a₁ b₀ b₁ : ℝ}
    (ha₀ : |a₀| ≤ 1) (ha₁ : |a₁| ≤ 1) (hb₀ : |b₀| ≤ 1) (hb₁ : |b₁| ≤ 1) :
    |a₀ * b₀ + a₀ * b₁ + a₁ * b₀ - a₁ * b₁| ≤ 2 := by

  rw [abs_le] at *
  constructor <;> cases abs_cases (a₀ + a₁) <;> cases abs_cases (b₀ + b₁) <;>
    nlinarith [mul_nonneg (sub_nonneg.2 ha₀.1) (sub_nonneg.2 hb₀.1),
      mul_nonneg (sub_nonneg.2 ha₀.2) (sub_nonneg.2 hb₀.2),
      mul_nonneg (sub_nonneg.2 ha₁.1) (sub_nonneg.2 hb₁.1),
      mul_nonneg (sub_nonneg.2 ha₁.2) (sub_nonneg.2 hb₁.2)]
