-- Generated from ChapterGaugeComprehensiveFixing.lean — theorem BookProof.ChapterGaugeComprehensiveFixing.unitCell_indicator_not_isPhysicalObservable
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeComprehensiveFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}
variable {X : Type*} [TopologicalSpace X] {G : Type*} [Group G] [MulAction G X]
variable (X : Type*) (G : Type*) [Group G] [MulAction G X]



open BookProof.ChapterGaugeIncompleteFixing

theorem BookProof.ChapterGaugeComprehensiveFixing.unitCell_indicator_not_isPhysicalObservable :
    ¬ IsPhysicalObservable (Multiplicative ℤ)
        (unitCell.indicator (fun _ => (1 : ℝ))) := by sorry
