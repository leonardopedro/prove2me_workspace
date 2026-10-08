-- Generated from ChapterF4.lean — theorem BookProof.ChapterF4.countSketch_unbiased
import Mathlib
import Definitions.Def_ChapterF4
open BookProof.ChapterF4


open scoped BigOperators Matrix
open MeasureTheory

variable {d k : ℕ}
variable {A : Type*} [NormedRing A] [NormedAlgebra ℂ A] [StarRing A] [ContinuousStar A]
  [CompleteSpace A] [StarModule ℂ A]
variable {α κ Ω : Type*} [Fintype α] [DecidableEq α] [Fintype κ] [DecidableEq κ]
  {mΩ : MeasurableSpace Ω}

theorem BookProof.ChapterF4.countSketch_unbiased (μ : Measure Ω) [IsProbabilityMeasure μ]
    (hash : α → κ) (s : α → Ω → ℝ) (x y : α → ℝ)
    (hint : ∀ c c', Integrable (fun ω => s c ω * s c' ω) μ)
    (hs : ∀ c c', ∫ ω, s c ω * s c' ω ∂μ = if c = c' then 1 else 0) :
    ∫ ω, (∑ h, countSketch hash s x ω h * countSketch hash s y ω h) ∂μ
      = ∑ c, x c * y c := by sorry
