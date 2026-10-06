-- Generated from ChapterLinftyMaximalAbelian.lean — theorem BookProof.ChapterLinftyMaximalAbelian.multOp_algebra_maximal_abelian
import Mathlib
import Definitions.Def_ChapterLinftyMaximalAbelian
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterLinftyMaximalAbelian

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication


theorem BookProof.ChapterLinftyMaximalAbelian.multOp_algebra_maximal_abelian (T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ)
    (hT : CommutesWithMultOps T) :
    ∃ (ψ : α → ℂ) (hψ : MemLp ψ ⊤ μ), T = multOp ψ hψ := by sorry
