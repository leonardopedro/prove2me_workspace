-- Generated from ChapterLinftyMaximalAbelian.lean — theorem BookProof.ChapterLinftyMaximalAbelian.commutant_eq_multOp
import Mathlib
import Definitions.Def_ChapterLinftyMaximalAbelian
import Definitions.Def_ChapterLinftyMultiplication
import Theorems.Thm_BookProof_ChapterLinftyMaximalAbelian_memLp_top_symbol
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterLinftyMaximalAbelian


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]


theorem BookProof.ChapterLinftyMaximalAbelian.commutant_eq_multOp {T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ} (hT : CommutesWithMultOps T) :
    T = multOp (symbol T) (memLp_top_symbol hT) := by sorry
