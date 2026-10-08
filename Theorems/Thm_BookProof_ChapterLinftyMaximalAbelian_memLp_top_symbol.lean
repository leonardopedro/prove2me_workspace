-- Generated from ChapterLinftyMaximalAbelian.lean — theorem BookProof.ChapterLinftyMaximalAbelian.memLp_top_symbol
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterLinftyMaximalAbelian
open BookProof.ChapterLinftyMaximalAbelian


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]


theorem BookProof.ChapterLinftyMaximalAbelian.memLp_top_symbol {T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ} (hT : CommutesWithMultOps T) :
    MemLp (symbol T) ⊤ μ := by sorry
