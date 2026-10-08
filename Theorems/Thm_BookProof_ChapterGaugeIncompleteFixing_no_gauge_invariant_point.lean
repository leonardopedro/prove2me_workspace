-- Generated from ChapterGaugeIncompleteFixing.lean — theorem BookProof.ChapterGaugeIncompleteFixing.no_gauge_invariant_point
import Mathlib
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing


open scoped InnerProductSpace

variable {X : Type*}
variable (G : Type*) [Group G] [MulAction G X]

theorem BookProof.ChapterGaugeIncompleteFixing.no_gauge_invariant_point [Nontrivial G] (h : MovesEveryPointOfSpectrum G X)
    (x : X) : ∃ g : G, g • x ≠ x := by sorry
