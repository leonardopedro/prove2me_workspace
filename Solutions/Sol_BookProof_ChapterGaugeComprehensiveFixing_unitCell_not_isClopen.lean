-- Generated from ChapterGaugeComprehensiveFixing.lean — solution of BookProof.ChapterGaugeComprehensiveFixing.unitCell_not_isClopen
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
import Theorems.Thm_BookProof_ChapterGaugeComprehensiveFixing_unitCell_isComprehensiveGaugeFixing
import Theorems.Thm_BookProof_ChapterGaugeComprehensiveFixing_unitCell_isCompleteGaugeFixing'
import Theorems.Thm_BookProof_ChapterGaugeComprehensiveFixing_shift_no_clopen_complete_gaugeFixing
open BookProof.ChapterGaugeComprehensiveFixing




open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}
variable {X : Type*} [TopologicalSpace X] {G : Type*} [Group G] [MulAction G X]
variable (X : Type*) (G : Type*) [Group G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution : ¬ IsClopen unitCell :=
  shift_no_clopen_complete_gaugeFixing unitCell_isComprehensiveGaugeFixing
      unitCell_isCompleteGaugeFixing'
