-- Generated from ChapterSolovayHilbertTensor.lean — solution of BookProof.ChapterSolovayHilbertTensor.inner_tensorLp
import Mathlib
import Definitions.Def_ChapterSolovayHilbertTensor
open BookProof.ChapterSolovayHilbertTensor



noncomputable section

open MeasureTheory ProbabilityTheory
open scoped ENNReal


open BookProof.ChapterSolovayCoordinates

variable {A B C D : Type*} [MeasurableSpace A] [MeasurableSpace B] [MeasurableSpace C]
  [MeasurableSpace D]
variable {N₁ N₂ : ℕ}
variable {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
variable {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
  {μ : Measure α} {ν : Measure β} [SFinite μ] [SFinite ν]

set_option maxHeartbeats 1000000 in
theorem solution {f₁ f₂ : α → ℂ} {g₁ g₂ : β → ℂ}
    (hf₁ : MemLp f₁ 2 μ) (hf₂ : MemLp f₂ 2 μ) (hg₁ : MemLp g₁ 2 ν) (hg₂ : MemLp g₂ 2 ν) :
    (inner ℂ (tensorLp hf₁ hg₁) (tensorLp hf₂ hg₂) : ℂ)
      = (inner ℂ (hf₁.toLp f₁) (hf₂.toLp f₂) : ℂ) * (inner ℂ (hg₁.toLp g₁) (hg₂.toLp g₂) : ℂ) := by

  rw [L2.inner_def, L2.inner_def, L2.inner_def]
  have h1 : ∀ᵐ z : α × β ∂(μ.prod ν),
      (inner ℂ ((tensorLp hf₁ hg₁ : α × β → ℂ) z) ((tensorLp hf₂ hg₂ : α × β → ℂ) z) : ℂ)
        = (starRingEnd ℂ) (f₁ z.1) * f₂ z.1 * ((starRingEnd ℂ) (g₁ z.2) * g₂ z.2) := by
    filter_upwards [(tensorMemLp hf₁ hg₁).coeFn_toLp, (tensorMemLp hf₂ hg₂).coeFn_toLp]
      with z hz1 hz2
    rw [tensorLp, tensorLp] at *
    rw [hz1, hz2, RCLike.inner_apply, map_mul]
    ring
  rw [integral_congr_ae h1]
  have h2 := integral_prod_mul (μ := μ) (ν := ν)
    (fun x => (starRingEnd ℂ) (f₁ x) * f₂ x) (fun y => (starRingEnd ℂ) (g₁ y) * g₂ y)
  rw [h2]
  congr 1
  · refine integral_congr_ae ?_
    filter_upwards [hf₁.coeFn_toLp, hf₂.coeFn_toLp] with x hx1 hx2
    rw [hx1, hx2, RCLike.inner_apply]
    ring
  · refine integral_congr_ae ?_
    filter_upwards [hg₁.coeFn_toLp, hg₂.coeFn_toLp] with y hy1 hy2
    rw [hy1, hy2, RCLike.inner_apply]
    ring
