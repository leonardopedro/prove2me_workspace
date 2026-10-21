-- Generated from ChapterGaugeComprehensiveFixing.lean — solution of BookProof.ChapterGaugeComprehensiveFixing.unitCell_indicator_not_isPhysicalObservable
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
import Theorems.Thm_BookProof_ChapterGaugeComprehensiveFixing_not_isPhysicalObservable_indicator
import Theorems.Thm_BookProof_ChapterGaugeComprehensiveFixing_unitCell_isComprehensiveGaugeFixing
import Theorems.Thm_BookProof_ChapterGaugeComprehensiveFixing_unitCell_isCompleteGaugeFixing_prime
import Theorems.Thm_BookProof_ChapterGaugeComprehensiveFixing_shift_movesEveryPointOfSpectrum
open BookProof.ChapterGaugeComprehensiveFixing




open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}
variable {X : Type*} [TopologicalSpace X] {G : Type*} [Group G] [MulAction G X]
variable (X : Type*) (G : Type*) [Group G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ IsPhysicalObservable (Multiplicative ℤ)
        (unitCell.indicator (fun _ => (1 : ℝ))) :=
  not_isPhysicalObservable_indicator unitCell_isComprehensiveGaugeFixing
      unitCell_isCompleteGaugeFixing_prime shift_movesEveryPointOfSpectrum
