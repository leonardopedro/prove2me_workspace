-- Generated from ChapterLinftyMaximalAbelian.lean — theorem BookProof.ChapterLinftyMaximalAbelian.symbol_mul
import Mathlib
import Definitions.Def_ChapterLinftyMaximalAbelian
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterLinftyMaximalAbelian

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication


theorem BookProof.ChapterLinftyMaximalAbelian.symbol_mul {T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ} (hT : CommutesWithMultOps T)
    (φ : α → ℂ) (hφ : MemLp φ ⊤ μ) :
    ((T (multOp φ hφ (oneLp μ))) : α → ℂ) =ᵐ[μ] fun x => φ x * symbol T x := by sorry
