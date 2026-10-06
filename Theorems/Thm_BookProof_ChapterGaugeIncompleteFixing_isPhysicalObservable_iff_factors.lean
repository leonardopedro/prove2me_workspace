-- Generated from ChapterGaugeIncompleteFixing.lean — theorem BookProof.ChapterGaugeIncompleteFixing.isPhysicalObservable_iff_factors
import Mathlib
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*}
variable (G : Type*) [Group G] [MulAction G X]


open scoped InnerProductSpace

theorem BookProof.ChapterGaugeIncompleteFixing.isPhysicalObservable_iff_factors (f : X → ℝ) :
    IsPhysicalObservable G f ↔
      ∃ F : Quotient (MulAction.orbitRel G X) → ℝ,
        ∀ x : X, f x = F (Quotient.mk (MulAction.orbitRel G X) x) := by sorry
