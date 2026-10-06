-- Generated from ChapterLinftyMultiplication.lean — theorem BookProof.ChapterLinftyMultiplication.multOp_coeFn
import Mathlib
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


noncomputable section

open MeasureTheory ENNReal Complex



theorem BookProof.ChapterLinftyMultiplication.multOp_coeFn (φ : α → ℂ) (hφ : MemLp φ ⊤ μ) (f : Lp ℂ 2 μ) :
    (multOp φ hφ f : α → ℂ) =ᵐ[μ] fun x => φ x * (f : α → ℂ) x := by sorry
