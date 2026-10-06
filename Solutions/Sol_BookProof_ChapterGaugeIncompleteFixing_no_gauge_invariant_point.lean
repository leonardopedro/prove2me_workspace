-- Generated from ChapterGaugeIncompleteFixing.lean — solution of BookProof.ChapterGaugeIncompleteFixing.no_gauge_invariant_point
import Mathlib
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing



open scoped InnerProductSpace

variable {X : Type*}
variable (G : Type*) [Group G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial G] (h : MovesEveryPointOfSpectrum G X)
    (x : X) : ∃ g : G, g • x ≠ x := by

  obtain ⟨g, hg⟩ := exists_ne (1 : G)
  exact ⟨g, h g hg x⟩
