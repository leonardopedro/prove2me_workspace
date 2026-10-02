-- Generated from ChapterStoneMeasurable.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.ae_inner_eq_zero
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_locallyIntegrable_of_bounded
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (G : WeakMeasurableUnitaryGroup H)

set_option maxHeartbeats 1000000 in
theorem solution (z x : H)
    (h : ∀ a : ℝ, (∫ t in (0:ℝ)..a, ⟪ z, G.U t x ⟫_ℂ) = 0) :
    ∀ᵐ t : ℝ, ⟪ z, G.U t x ⟫_ℂ = 0 := by

  have hmeas : Measurable fun t => ⟪ z, G.U t x ⟫_ℂ := G.weaklyMeasurable x z
  have hbd : ∀ t, ‖⟪ z, G.U t x ⟫_ℂ‖ ≤ ‖z‖ * ‖x‖ := fun t => G.norm_inner_le t x z
  have hre : LocallyIntegrable (fun t => (⟪ z, G.U t x ⟫_ℂ).re) volume :=
    locallyIntegrable_of_bounded (M := ‖z‖ * ‖x‖) hmeas.re
      (fun t => le_trans (by simpa using RCLike.norm_re_le_norm (K := ℂ) _) (hbd t))
  have him : LocallyIntegrable (fun t => (⟪ z, G.U t x ⟫_ℂ).im) volume :=
    locallyIntegrable_of_bounded (M := ‖z‖ * ‖x‖) hmeas.im
      (fun t => le_trans (by simpa using RCLike.norm_im_le_norm (K := ℂ) _) (hbd t))
  have hzre : ∀ a : ℝ, (∫ t in (0:ℝ)..a, (⟪ z, G.U t x ⟫_ℂ).re) = 0 := by
    intro a
    have := Complex.reCLM.intervalIntegral_comp_comm (G.intervalIntegrable_inner x z 0 a)
    simpa [h a] using this
  have hzim : ∀ a : ℝ, (∫ t in (0:ℝ)..a, (⟪ z, G.U t x ⟫_ℂ).im) = 0 := by
    intro a
    have := Complex.imCLM.intervalIntegral_comp_comm (G.intervalIntegrable_inner x z 0 a)
    simpa [h a] using this
  filter_upwards [LocallyIntegrable.ae_hasDerivAt_integral hre,
    LocallyIntegrable.ae_hasDerivAt_integral him] with t hrt hit
  have h1 := hrt 0
  have h2 := hit 0
  rw [funext hzre] at h1
  rw [funext hzim] at h2
  have e1 : (⟪ z, G.U t x ⟫_ℂ).re = 0 :=
    ((hasDerivAt_const t (0:ℝ)).unique h1).symm
  have e2 : (⟪ z, G.U t x ⟫_ℂ).im = 0 :=
    ((hasDerivAt_const t (0:ℝ)).unique h2).symm
  exact Complex.ext e1 e2
