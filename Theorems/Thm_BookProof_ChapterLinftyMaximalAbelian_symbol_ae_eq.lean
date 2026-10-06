-- Generated from ChapterLinftyMaximalAbelian.lean — theorem BookProof.ChapterLinftyMaximalAbelian.symbol_ae_eq
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterLinftyMaximalAbelian
open BookProof.ChapterLinftyMaximalAbelian

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication


theorem BookProof.ChapterLinftyMaximalAbelian.symbol_ae_eq (T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ) :
    (T (oneLp μ) : α → ℂ) =ᵐ[μ] symbol T := by sorry
