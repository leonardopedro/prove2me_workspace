-- Generated from ChapterSirkSingleTimeShift.lean — theorem BookProof.SirkSingleTime.isShiftInvertC_neg_resCLM_shift
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterHashimotoComplexShifts
import Definitions.Def_ChapterStoneConverse
import Definitions.Def_ChapterStoneResolvent
open BookProof.HashimotoShiftInvert
open `BookProof.HashimotoShiftInvert`.
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup
open BookProof.SirkSingleTime


open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {T : UnboundedSelfAdjoint E} {S : ℕ → UnboundedSelfAdjoint E}

theorem BookProof.SirkSingleTime.isShiftInvertC_neg_resCLM_shift (T : UnboundedSelfAdjoint E) {l : ℝ} (hl : l ≠ 0) :
    IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) := by sorry
