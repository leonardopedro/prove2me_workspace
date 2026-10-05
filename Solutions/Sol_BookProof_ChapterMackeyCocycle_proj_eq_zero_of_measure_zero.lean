-- Generated from ChapterMackeyCocycle.lean — solution of BookProof.ChapterMackeyCocycle.proj_eq_zero_of_measure_zero
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
open BookProof.ChapterMackeyCocycle



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) {E : Set X} (hE : MeasurableSet E)
    (h0 : μ E = 0) (f : Lp ℂ 2 μ) : proj μ hE f = 0 := by

  have hae : ∀ᵐ x ∂μ, x ∉ E := by
    rw [ae_iff]
    simpa using h0
  rw [Lp.eq_zero_iff_ae_eq_zero]
  filter_upwards [proj_coeFn μ hE f, hae] with x e1 e3
  simp [e1, Set.indicator_of_notMem e3]
