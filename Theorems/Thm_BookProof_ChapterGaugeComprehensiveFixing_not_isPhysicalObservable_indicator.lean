-- Generated from ChapterGaugeComprehensiveFixing.lean — theorem BookProof.ChapterGaugeComprehensiveFixing.not_isPhysicalObservable_indicator
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeComprehensiveFixing



open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}

theorem BookProof.ChapterGaugeComprehensiveFixing.not_isPhysicalObservable_indicator [Nontrivial G] [Nonempty X]
    (hcomp : IsComprehensiveGaugeFixing G S) (hcompl : IsCompleteGaugeFixing' G S)
    (hfree : MovesEveryPointOfSpectrum G X) :
    ¬ IsPhysicalObservable G (S.indicator (fun _ => (1 : ℝ))) := by sorry
