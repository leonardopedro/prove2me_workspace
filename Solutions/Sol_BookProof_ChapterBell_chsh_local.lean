-- Generated from ChapterBell.lean — solution of BookProof.ChapterBell.chsh_local
import Mathlib
import Definitions.Def_ChapterBell
import Theorems.Thm_BookProof_ChapterBell_chsh_pointwise
open BookProof.ChapterBell



open scoped BigOperators
open MeasureTheory

variable {Ω : Type*} [MeasurableSpace Ω]

set_option maxHeartbeats 1000000 in
theorem solution
    (μ : Measure Ω) [IsProbabilityMeasure μ]
    (A₀ A₁ B₀ B₁ : Ω → ℝ)
    (bA₀ : ∀ ω, |A₀ ω| ≤ 1) (bA₁ : ∀ ω, |A₁ ω| ≤ 1)
    (bB₀ : ∀ ω, |B₀ ω| ≤ 1) (bB₁ : ∀ ω, |B₁ ω| ≤ 1) :
    |∫ ω, (A₀ ω * B₀ ω + A₀ ω * B₁ ω + A₁ ω * B₀ ω - A₁ ω * B₁ ω) ∂μ| ≤ 2 := by

  refine le_trans (MeasureTheory.norm_integral_le_integral_norm (_ : Ω → ℝ))
    (le_trans (MeasureTheory.integral_mono_of_nonneg
      (Filter.Eventually.of_forall fun ω => norm_nonneg _) (by norm_num)
      (Filter.Eventually.of_forall fun ω =>
        chsh_pointwise (bA₀ ω) (bA₁ ω) (bB₀ ω) (bB₁ ω))) (by norm_num))
