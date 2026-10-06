-- Generated from ChapterGaugeIncompleteFixing.lean — solution of BookProof.ChapterGaugeIncompleteFixing.remnant_faithful
import Mathlib
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing



open scoped InnerProductSpace

variable {X : Type*}
variable (G : Type*) [Group G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution [Nonempty X] (h : MovesEveryPointOfSpectrum G X)
    {g : G} (hg : ∀ x : X, g • x = x) : g = 1 := by

  by_contra hne
  obtain ⟨x⟩ := ‹Nonempty X›
  exact h g hne x (hg x)
