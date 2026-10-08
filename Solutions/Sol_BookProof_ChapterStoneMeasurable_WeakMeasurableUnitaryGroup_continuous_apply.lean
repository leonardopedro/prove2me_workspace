-- Generated from ChapterStoneMeasurable.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.continuous_apply
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_apply_apply
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_tendsto_apply_zero
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (G : WeakMeasurableUnitaryGroup H)

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace H] [TopologicalSpace.SeparableSpace H] (x : H) :
    Continuous fun t : ℝ => G.U t x := by

  refine continuous_iff_continuousAt.mpr fun t₀ => ?_
  have hshift : Tendsto (fun s : ℝ => G.U t₀ (G.U s x)) (𝓝 0) (𝓝 (G.U t₀ x)) :=
    ((G.U t₀).continuous.tendsto x).comp (G.tendsto_apply_zero x)
  have hcomp : Tendsto (fun t : ℝ => t - t₀) (𝓝 t₀) (𝓝 0) := by
    have : Tendsto (fun t : ℝ => t - t₀) (𝓝 t₀) (𝓝 (t₀ - t₀)) :=
      (continuous_id.sub continuous_const).tendsto t₀
    simpa using this
  have := hshift.comp hcomp
  refine this.congr fun t => ?_
  simp only [Function.comp_apply]
  rw [G.apply_apply]
  ring_nf
