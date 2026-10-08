-- Generated from ChapterLinftyMaximalAbelian.lean — theorem BookProof.ChapterLinftyMaximalAbelian.oneLp_coeFn
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterLinftyMaximalAbelian
open BookProof.ChapterLinftyMaximalAbelian


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]


theorem BookProof.ChapterLinftyMaximalAbelian.oneLp_coeFn : (oneLp μ : α → ℂ) =ᵐ[μ] fun _ => (1 : ℂ) := by sorry
