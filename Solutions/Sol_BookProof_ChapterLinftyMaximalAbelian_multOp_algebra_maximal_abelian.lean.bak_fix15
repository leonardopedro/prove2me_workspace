-- Generated from ChapterLinftyMaximalAbelian.lean — solution of BookProof.ChapterLinftyMaximalAbelian.multOp_algebra_maximal_abelian
import Mathlib
import Definitions.Def_ChapterLinftyMaximalAbelian
import Theorems.Thm_BookProof_ChapterLinftyMaximalAbelian_memLp_top_symbol
import Theorems.Thm_BookProof_ChapterLinftyMaximalAbelian_commutant_eq_multOp
open BookProof.ChapterLinftyMaximalAbelian



noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]

set_option maxHeartbeats 1000000 in
theorem solution (T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ)
    (hT : CommutesWithMultOps T) :
    ∃ (ψ : α → ℂ) (hψ : MemLp ψ ⊤ μ), T = multOp ψ hψ := ⟨symbol T, memLp_top_symbol hT, commutant_eq_multOp hT⟩
