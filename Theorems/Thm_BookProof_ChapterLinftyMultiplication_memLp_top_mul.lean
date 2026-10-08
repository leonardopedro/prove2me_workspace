-- Generated from ChapterLinftyMultiplication.lean — theorem BookProof.ChapterLinftyMultiplication.memLp_top_mul
import Mathlib
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication


noncomputable section

open MeasureTheory ENNReal Complex


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


theorem BookProof.ChapterLinftyMultiplication.memLp_top_mul {φ ψ : α → ℂ} (hφ : MemLp φ ⊤ μ) (hψ : MemLp ψ ⊤ μ) :
    MemLp (fun x => φ x * ψ x) ⊤ μ := by sorry
