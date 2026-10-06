-- Generated from ChapterBell.lean — theorem BookProof.ChapterBell.chsh_local
import Mathlib
import Definitions.Def_ChapterBell
open BookProof.ChapterBell

variable {Ω : Type*} [MeasurableSpace Ω]


open scoped BigOperators
open MeasureTheory

theorem BookProof.ChapterBell.chsh_local
    (μ : Measure Ω) [IsProbabilityMeasure μ]
    (A₀ A₁ B₀ B₁ : Ω → ℝ)
    (bA₀ : ∀ ω, |A₀ ω| ≤ 1) (bA₁ : ∀ ω, |A₁ ω| ≤ 1)
    (bB₀ : ∀ ω, |B₀ ω| ≤ 1) (bB₁ : ∀ ω, |B₁ ω| ≤ 1) :
    |∫ ω, (A₀ ω * B₀ ω + A₀ ω * B₁ ω + A₁ ω * B₀ ω - A₁ ω * B₁ ω) ∂μ| ≤ 2 := by sorry
