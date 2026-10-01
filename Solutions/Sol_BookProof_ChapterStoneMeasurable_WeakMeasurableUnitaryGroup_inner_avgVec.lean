-- Generated from ChapterStoneMeasurable.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.inner_avgVec
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace H] (x : H) (a : ℝ) (y : H) :
    ⟪ y, G.avgVec x a ⟫_ℂ = ∫ t in (0 : ℝ)..a, ⟪ y, G.U t x ⟫_ℂ := by

  have h : ⟪ G.avgVec x a, y ⟫_ℂ = G.avgFunctional x a y := by
    rw [avgVec, ← InnerProductSpace.toDual_apply_apply (𝕜 := ℂ)]
    simp
  rw [← inner_conj_symm, h]
  simp [avgFunctional]
