-- Generated from ChapterLinftyMultiplication.lean — theorem BookProof.ChapterLinftyMultiplication.memLp_top_conj
import Mathlib
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication


noncomputable section

open MeasureTheory ENNReal Complex


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


theorem BookProof.ChapterLinftyMultiplication.memLp_top_conj {φ : α → ℂ} (hφ : MemLp φ ⊤ μ) :
    MemLp (fun x => (starRingEnd ℂ) (φ x)) ⊤ μ := by sorry
