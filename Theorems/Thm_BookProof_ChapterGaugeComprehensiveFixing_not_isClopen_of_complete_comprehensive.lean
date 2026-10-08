-- Generated from ChapterGaugeComprehensiveFixing.lean — theorem BookProof.ChapterGaugeComprehensiveFixing.not_isClopen_of_complete_comprehensive
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeComprehensiveFixing



open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}
variable {X : Type*} [TopologicalSpace X] {G : Type*} [Group G] [MulAction G X]

theorem BookProof.ChapterGaugeComprehensiveFixing.not_isClopen_of_complete_comprehensive [PreconnectedSpace X] [Nonempty X]
    [Nontrivial G] {S : Set X}
    (hcomp : IsComprehensiveGaugeFixing G S) (hcompl : IsCompleteGaugeFixing' G S)
    (hfree : MovesEveryPointOfSpectrum G X) :
    ¬ IsClopen S := by sorry
