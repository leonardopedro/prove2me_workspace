-- Generated from ChapterBell.lean — theorem BookProof.ChapterBell.chsh_pointwise
import Mathlib
import Definitions.Def_ChapterBell
open BookProof.ChapterBell


open scoped BigOperators
open MeasureTheory

theorem BookProof.ChapterBell.chsh_pointwise {a₀ a₁ b₀ b₁ : ℝ}
    (ha₀ : |a₀| ≤ 1) (ha₁ : |a₁| ≤ 1) (hb₀ : |b₀| ≤ 1) (hb₁ : |b₁| ≤ 1) :
    |a₀ * b₀ + a₀ * b₁ + a₁ * b₀ - a₁ * b₁| ≤ 2 := by sorry
