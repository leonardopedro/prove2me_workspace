-- Generated from ChapterLinftyMultiplication.lean — theorem BookProof.ChapterLinftyMultiplication.multOp_eq_zero_iff
import Mathlib
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


noncomputable section

open MeasureTheory ENNReal Complex



theorem BookProof.ChapterLinftyMultiplication.multOp_eq_zero_iff [IsFiniteMeasure μ] (φ : α → ℂ) (hφ : MemLp φ ⊤ μ) :
    multOp φ hφ = 0 ↔ φ =ᵐ[μ] 0 := by sorry
