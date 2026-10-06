-- Generated from ChapterLinftyMaximalAbelian.lean — theorem BookProof.ChapterLinftyMaximalAbelian.stronglyMeasurable_symbol
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterLinftyMaximalAbelian
open BookProof.ChapterLinftyMaximalAbelian

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication


theorem BookProof.ChapterLinftyMaximalAbelian.stronglyMeasurable_symbol (T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ) :
    StronglyMeasurable (symbol T) := by sorry
