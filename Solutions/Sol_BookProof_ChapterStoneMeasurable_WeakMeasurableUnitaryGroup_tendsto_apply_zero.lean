-- Generated from ChapterStoneMeasurable.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.tendsto_apply_zero
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_avgSpan_le_contSubmodule
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_dense_avgSpan
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (G : WeakMeasurableUnitaryGroup H)

set_option maxHeartbeats 1000000 in
## Von Neumann's theorem: weak measurability implies strong continuity -/

theorem solution [CompleteSpace H] [TopologicalSpace.Separabl :=
  eSpace H] (x : H) :
      Tendsto (fun s : ℝ => G.U s x) (𝓝 0) (𝓝 x) := by
    rw [Metric.tendsto_nhds]
    intro ε hε
    obtain ⟨v, hv, hvx⟩ : ∃ v ∈ (G.avgSpan : Set H), dist x v < ε / 3 := by
      have hx : x ∈ closure (G.avgSpan : Set H) := G.dense_avgSpan x
      exact (Metric.mem_closure_iff.mp hx) (ε / 3) (by linarith)
    have hvc : Tendsto (fun s : ℝ => G.U s v) (𝓝 0) (𝓝 v) :=
      G.avgSpan_le_contSubmodule hv
    filter_upwards [Metric.tendsto_nhds.mp hvc (ε / 3) (by linarith)] with s hs
    have h1 : dist (G.U s x) (G.U s v) = dist x v := by
      rw [dist_eq_norm, dist_eq_norm, ← map_sub]
      exact G.norm_map s _
    have h2 : dist v x = dist x v := dist_comm v x
    calc dist (G.U s x) x ≤ dist (G.U s x) (G.U s v) + dist (G.U s v) v + dist v x :=
          dist_triangle4 _ _ _ _
      _ <
