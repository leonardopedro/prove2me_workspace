-- Generated from ChapterEll2Separable.lean — solution of BookProof.ChapterEll2Separable.ratVec_range_countable
import Mathlib
import Definitions.Def_ChapterEll2Separable
open BookProof.ChapterEll2Separable



open Filter Finset
open scoped ENNReal


open BookProof.ChapterRieszFischer

set_option maxHeartbeats 1000000 in
theorem solution : (Set.range ratVec).Countable := Set.countable_range _
