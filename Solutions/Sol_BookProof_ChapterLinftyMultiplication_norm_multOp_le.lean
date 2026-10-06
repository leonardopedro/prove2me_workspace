-- Generated from ChapterLinftyMultiplication.lean — solution of BookProof.ChapterLinftyMultiplication.norm_multOp_le
import Mathlib
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication



noncomputable section

open MeasureTheory ENNReal Complex


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution (φ : α → ℂ) (hφ : MemLp φ ⊤ μ) :
    ‖multOp φ hφ‖ ≤ (eLpNorm φ ⊤ μ).toReal := LinearMap.mkContinuous_norm_le _ ENNReal.toReal_nonneg _
