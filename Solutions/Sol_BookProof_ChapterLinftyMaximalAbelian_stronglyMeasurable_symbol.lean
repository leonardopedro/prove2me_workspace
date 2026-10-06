-- Generated from ChapterLinftyMaximalAbelian.lean — solution of BookProof.ChapterLinftyMaximalAbelian.stronglyMeasurable_symbol
import Mathlib
import Definitions.Def_ChapterLinftyMaximalAbelian
open BookProof.ChapterLinftyMaximalAbelian



noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]

set_option maxHeartbeats 1000000 in
theorem solution (T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ) :
    StronglyMeasurable (symbol T) := (Lp.aestronglyMeasurable (T (oneLp μ))).stronglyMeasurable_mk
