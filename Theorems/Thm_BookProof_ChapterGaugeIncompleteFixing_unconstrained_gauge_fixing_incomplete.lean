-- Generated from ChapterGaugeIncompleteFixing.lean — theorem BookProof.ChapterGaugeIncompleteFixing.unconstrained_gauge_fixing_incomplete
import Mathlib
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*}
variable (G : Type*) [Group G] [MulAction G X]


open scoped InnerProductSpace

theorem BookProof.ChapterGaugeIncompleteFixing.unconstrained_gauge_fixing_incomplete [Nontrivial G] [Nonempty X]
    (h : MovesEveryPointOfSpectrum G X) :
    ¬ IsCompleteGaugeFixing' G (Set.univ : Set X) := by sorry
