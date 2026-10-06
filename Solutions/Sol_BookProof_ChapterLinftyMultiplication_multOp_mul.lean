-- Generated from ChapterLinftyMultiplication.lean — solution of BookProof.ChapterLinftyMultiplication.multOp_mul
import Mathlib
import Definitions.Def_ChapterLinftyMultiplication
import Theorems.Thm_BookProof_ChapterLinftyMultiplication_multOp_coeFn
import Theorems.Thm_BookProof_ChapterLinftyMultiplication_memLp_top_mul
open BookProof.ChapterLinftyMultiplication



noncomputable section

open MeasureTheory ENNReal Complex


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution (φ ψ : α → ℂ) (hφ : MemLp φ ⊤ μ) (hψ : MemLp ψ ⊤ μ) :
    (multOp φ hφ).comp (multOp ψ hψ) = multOp (fun x => φ x * ψ x) (memLp_top_mul hφ hψ) := by

  refine ContinuousLinearMap.ext fun f => Lp.ext ?_
  filter_upwards [multOp_coeFn φ hφ (multOp ψ hψ f), multOp_coeFn ψ hψ f,
    multOp_coeFn (fun x => φ x * ψ x) (memLp_top_mul hφ hψ) f] with x h1 h2 h3
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply, h1, h2, h3]
  ring
