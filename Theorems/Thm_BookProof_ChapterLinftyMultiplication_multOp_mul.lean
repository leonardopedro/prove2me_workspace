-- Generated from ChapterLinftyMultiplication.lean — theorem BookProof.ChapterLinftyMultiplication.multOp_mul
import Mathlib
import Definitions.Def_ChapterLinftyMultiplication
import Theorems.Thm_BookProof_ChapterLinftyMultiplication_memLp_top_mul
open BookProof.ChapterLinftyMultiplication


noncomputable section

open MeasureTheory ENNReal Complex


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


theorem BookProof.ChapterLinftyMultiplication.multOp_mul (φ ψ : α → ℂ) (hφ : MemLp φ ⊤ μ) (hψ : MemLp ψ ⊤ μ) :
    (multOp φ hφ).comp (multOp ψ hψ) = multOp (fun x => φ x * ψ x) (memLp_top_mul hφ hψ) := by sorry
