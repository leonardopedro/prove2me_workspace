-- Generated from ChapterSolovayHilbertTensor.lean — theorem BookProof.ChapterSolovayHilbertTensor.inner_tensorLp
import Definitions.Def_ChapterSolovayCoordinates
import Mathlib
import Definitions.Def_ChapterSolovayHilbertTensor
open BookProof.ChapterSolovayHilbertTensor

variable {A B C D : Type*} [MeasurableSpace A] [MeasurableSpace B] [MeasurableSpace C]
  [MeasurableSpace D]
variable {N₁ N₂ : ℕ}
variable {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
variable {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
  {μ : Measure α} {ν : Measure β} [SFinite μ] [SFinite ν]


noncomputable section

open MeasureTheory ProbabilityTheory
open scoped ENNReal


open BookProof.ChapterSolovayCoordinates

theorem BookProof.ChapterSolovayHilbertTensor.inner_tensorLp {f₁ f₂ : α → ℂ} {g₁ g₂ : β → ℂ}
    (hf₁ : MemLp f₁ 2 μ) (hf₂ : MemLp f₂ 2 μ) (hg₁ : MemLp g₁ 2 ν) (hg₂ : MemLp g₂ 2 ν) :
    (inner ℂ (tensorLp hf₁ hg₁) (tensorLp hf₂ hg₂) : ℂ)
      = (inner ℂ (hf₁.toLp f₁) (hf₂.toLp f₂) : ℂ) * (inner ℂ (hg₁.toLp g₁) (hg₂.toLp g₂) : ℂ) := by sorry
