-- Generated from ChapterLinftyMultiplication.lean — theorem BookProof.ChapterLinftyMultiplication.multOp_comm
import Mathlib
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication


noncomputable section

open MeasureTheory ENNReal Complex


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


theorem BookProof.ChapterLinftyMultiplication.multOp_comm (φ ψ : α → ℂ) (hφ : MemLp φ ⊤ μ) (hψ : MemLp ψ ⊤ μ) :
    (multOp φ hφ).comp (multOp ψ hψ) = (multOp ψ hψ).comp (multOp φ hφ) := by sorry
