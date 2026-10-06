-- Generated from ChapterEll2Separable.lean — solution of BookProof.ChapterEll2Separable.ell2_separable
import Mathlib
import Definitions.Def_ChapterEll2Separable
import Theorems.Thm_BookProof_ChapterEll2Separable_ratVec_range_countable
import Theorems.Thm_BookProof_ChapterEll2Separable_ratVec_dense
open BookProof.ChapterEll2Separable



open Filter Finset
open scoped ENNReal


open BookProof.ChapterRieszFischer

set_option maxHeartbeats 1000000 in
theorem solution : TopologicalSpace.SeparableSpace Ell2 := ⟨⟨Set.range ratVec, ratVec_range_countable, ratVec_dense⟩⟩
