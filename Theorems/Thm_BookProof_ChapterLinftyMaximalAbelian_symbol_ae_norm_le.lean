-- Generated from ChapterLinftyMaximalAbelian.lean — theorem BookProof.ChapterLinftyMaximalAbelian.symbol_ae_norm_le
import Mathlib
import Definitions.Def_ChapterLinftyMaximalAbelian
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterLinftyMaximalAbelian


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]


theorem BookProof.ChapterLinftyMaximalAbelian.symbol_ae_norm_le {T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ} (hT : CommutesWithMultOps T) :
    ∀ᵐ x ∂μ, ‖symbol T x‖ ≤ ‖T‖ := by sorry
