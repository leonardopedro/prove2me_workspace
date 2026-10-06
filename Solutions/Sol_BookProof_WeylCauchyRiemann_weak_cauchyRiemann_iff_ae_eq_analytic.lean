-- Generated from ChapterWeylCauchyRiemann.lean — solution of BookProof.WeylCauchyRiemann.weak_cauchyRiemann_iff_ae_eq_analytic
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
import Theorems.Thm_BookProof_WeylCauchyRiemann_weak_cauchyRiemann_ae_eq_analytic
import Theorems.Thm_BookProof_WeylCauchyRiemann_weakCauchyRiemannOn_of_analyticOn
import Theorems.Thm_BookProof_WeylCauchyRiemann_WeakCauchyRiemannOn_congr_ae
open BookProof.WeylCauchyRiemann




open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {f : ℂ → ℂ} {U : Set ℂ} (hU : IsOpen U)
    (hf : LocallyIntegrableOn f U) :
    WeakCauchyRiemannOn f U ↔ ∃ g : ℂ → ℂ, AnalyticOn ℂ g U ∧ ∀ᵐ z : ℂ, z ∈ U → f z = g z := by

  refine ⟨fun hCR => weak_cauchyRiemann_ae_eq_analytic hU hf hCR, ?_⟩
  rintro ⟨g, hg, hae⟩
  exact (weakCauchyRiemannOn_of_analyticOn hU hg).congr_ae hae
