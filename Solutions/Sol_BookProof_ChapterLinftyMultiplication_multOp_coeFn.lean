-- Generated from ChapterLinftyMultiplication.lean — solution of BookProof.ChapterLinftyMultiplication.multOp_coeFn
import Mathlib
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication



noncomputable section

open MeasureTheory ENNReal Complex


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution (φ : α → ℂ) (hφ : MemLp φ ⊤ μ) (f : Lp ℂ 2 μ) :
    (multOp φ hφ f : α → ℂ) =ᵐ[μ] fun x => φ x * (f : α → ℂ) x := MemLp.coeFn_toLp (mul_memLp_two hφ f)
