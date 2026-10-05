-- Generated from ChapterMackeyCocycle.lean — solution of BookProof.ChapterMackeyCocycle.norm_indSet_sq
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
open BookProof.ChapterMackeyCocycle



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) [IsFiniteMeasure μ] {E : Set X} (hE : MeasurableSet E) :
    ‖indSet μ hE‖ ^ 2 = (μ E).toReal := by

  rw [indSet, norm_indicatorConstLp (by norm_num) (by norm_num), norm_one, one_mul,
    show ((2 : ENNReal).toReal) = (2 : ℝ) by norm_num, ← Real.rpow_natCast _ 2,
    ← Real.rpow_mul measureReal_nonneg]
  norm_num
  simp [measureReal_def]
