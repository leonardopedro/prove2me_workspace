-- Generated from ChapterLinftyMultiplication.lean — theorem BookProof.ChapterLinftyMultiplication.norm_multOp_le
import Mathlib
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


noncomputable section

open MeasureTheory ENNReal Complex



theorem BookProof.ChapterLinftyMultiplication.norm_multOp_le (φ : α → ℂ) (hφ : MemLp φ ⊤ μ) :
    ‖multOp φ hφ‖ ≤ (eLpNorm φ ⊤ μ).toReal := by sorry
