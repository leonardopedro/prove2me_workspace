-- Generated from ChapterLinftyMultiplication.lean — theorem BookProof.ChapterLinftyMultiplication.multOp_inner_adjoint
import Mathlib
import Definitions.Def_ChapterLinftyMultiplication
import Theorems.Thm_BookProof_ChapterLinftyMultiplication_memLp_top_conj
open BookProof.ChapterLinftyMultiplication


noncomputable section

open MeasureTheory ENNReal Complex


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


theorem BookProof.ChapterLinftyMultiplication.multOp_inner_adjoint (φ : α → ℂ) (hφ : MemLp φ ⊤ μ) (f g : Lp ℂ 2 μ) :
    inner ℂ (multOp φ hφ f) g
      = inner ℂ f (multOp (fun x => (starRingEnd ℂ) (φ x)) (memLp_top_conj hφ) g) := by sorry
