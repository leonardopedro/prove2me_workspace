-- Generated from ChapterGaugeComprehensiveFixing.lean — solution of BookProof.ChapterGaugeComprehensiveFixing.unitCell_isComprehensiveGaugeFixing
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
import Theorems.Thm_BookProof_ChapterGaugeComprehensiveFixing_shift_smul_def
open BookProof.ChapterGaugeComprehensiveFixing




open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}
variable {X : Type*} [TopologicalSpace X] {G : Type*} [Group G] [MulAction G X]
variable (X : Type*) (G : Type*) [Group G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution :
    IsComprehensiveGaugeFixing (Multiplicative ℤ) unitCell := by

  intro x
  refine ⟨Int.fract x, ⟨Int.fract_nonneg x, Int.fract_lt_one x⟩,
    Multiplicative.ofAdd ⌊x⌋, ?_⟩
  rw [shift_smul_def]
  exact Int.floor_add_fract x
