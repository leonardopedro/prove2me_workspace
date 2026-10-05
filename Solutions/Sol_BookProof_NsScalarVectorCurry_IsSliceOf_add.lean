-- Generated from ChapterNsScalarVectorCurry.lean — solution of BookProof.NsScalarVectorCurry.IsSliceOf.add
import Mathlib
import Definitions.Def_ChapterNsScalarVectorCurry



open MeasureTheory Filter Set
open scoped ENNReal ComplexConjugate


noncomputable section

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W}

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W}
variable [SigmaFinite μ] [SigmaFinite ν]

set_option maxHeartbeats 1000000 in
theorem solution {f₁ f₂ : Lp (Lp ℂ 2 ν) 2 μ} {g₁ g₂ : Lp ℂ 2 (μ.prod ν)}
    (h₁ : IsSliceOf f₁ g₁) (h₂ : IsSliceOf f₂ g₂) : IsSliceOf (f₁ + f₂) (g₁ + g₂) := by

  have hg := Measure.ae_ae_of_ae_prod (Lp.coeFn_add g₁ g₂)
  filter_upwards [h₁, h₂, Lp.coeFn_add f₁ f₂, hg] with x e₁ e₂ e₃ e₄
  have e₅ := Lp.coeFn_add ((f₁ : V → Lp ℂ 2 ν) x) ((f₂ : V → Lp ℂ 2 ν) x)
  filter_upwards [e₁, e₂, e₄, e₅] with y d₁ d₂ d₄ d₅
  rw [e₃]
  simp only [Pi.add_apply] at d₅ ⊢
  rw [d₅, d₁, d₂, d₄]
  simp
