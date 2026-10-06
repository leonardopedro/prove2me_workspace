-- Generated from ChapterLinftyMaximalAbelian.lean — solution of BookProof.ChapterLinftyMaximalAbelian.symbol_ae_eq
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
    (T (oneLp μ) : α → ℂ) =ᵐ[μ] symbol T := (Lp.aestronglyMeasurable (T (oneLp μ))).ae_eq_mk
