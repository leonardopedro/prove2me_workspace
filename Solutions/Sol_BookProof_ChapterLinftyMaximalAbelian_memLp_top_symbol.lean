-- Generated from ChapterLinftyMaximalAbelian.lean — solution of BookProof.ChapterLinftyMaximalAbelian.memLp_top_symbol
import Mathlib
import Definitions.Def_ChapterLinftyMaximalAbelian
import Theorems.Thm_BookProof_ChapterLinftyMaximalAbelian_stronglyMeasurable_symbol
import Theorems.Thm_BookProof_ChapterLinftyMaximalAbelian_symbol_ae_norm_le
open BookProof.ChapterLinftyMaximalAbelian



noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]

set_option maxHeartbeats 1000000 in
theorem solution {T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ} (hT : CommutesWithMultOps T) :
    MemLp (symbol T) ⊤ μ :=
  memLp_top_of_bound (stronglyMeasurable_symbol T).aestronglyMeasurable ‖T‖
      (symbol_ae_norm_le hT)
