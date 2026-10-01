-- Generated from ChapterStoneMeasurable.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.avgSpan_orthogonal_eq_bot
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_surjective
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_inner_avgVec
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_ae_inner_eq_zero
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace H] [TopologicalSpace.SeparableSpace H] :
    G.avgSpanᗮ = ⊥ := by

  rw [Submodule.eq_bot_iff]
  intro z hz
  have hzero : ∀ (x : H) (a : ℝ), (∫ t in (0:ℝ)..a, ⟪ z, G.U t x ⟫_ℂ) = 0 := by
    intro x a
    have hmem : G.avgVec x a ∈ G.avgSpan :=
      Submodule.subset_span ⟨x, a, rfl⟩
    have := hz _ hmem
    rw [← G.inner_avgVec x a z, ← inner_conj_symm]
    simpa using congrArg (starRingEnd ℂ) this
  obtain ⟨D, hDcount, hDdense⟩ := TopologicalSpace.exists_countable_dense H
  have hDc : Countable D := hDcount.to_subtype
  have hae : ∀ᵐ t : ℝ, ∀ x : D, ⟪ z, G.U t (x : H) ⟫_ℂ = 0 :=
    ae_all_iff.mpr (fun x => G.ae_inner_eq_zero z (x : H) (hzero (x : H)))
  obtain ⟨t₀, ht₀⟩ := hae.exists
  have hcont : Continuous fun w : H => ⟪ z, G.U t₀ w ⟫_ℂ :=
    continuous_const.inner (G.U t₀).continuous
  have hall : ∀ w : H, ⟪ z, G.U t₀ w ⟫_ℂ = 0 := by
    have := Continuous.ext_on hDdense hcont continuous_const
      (fun w hw => ht₀ ⟨w, hw⟩)
    exact fun w => congrFun this w
  obtain ⟨w, hw⟩ := G.surjective t₀ z
  have := hall w
  rw [hw] at this
  exact inner_self_eq_zero.mp this
