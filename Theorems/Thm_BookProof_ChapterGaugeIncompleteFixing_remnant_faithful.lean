-- Generated from ChapterGaugeIncompleteFixing.lean — theorem BookProof.ChapterGaugeIncompleteFixing.remnant_faithful
import Mathlib
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*}
variable (G : Type*) [Group G] [MulAction G X]


open scoped InnerProductSpace

theorem BookProof.ChapterGaugeIncompleteFixing.remnant_faithful [Nonempty X] (h : MovesEveryPointOfSpectrum G X)
    {g : G} (hg : ∀ x : X, g • x = x) : g = 1 := by sorry
