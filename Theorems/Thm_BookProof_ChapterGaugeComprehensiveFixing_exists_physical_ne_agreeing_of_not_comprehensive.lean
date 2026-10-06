-- Generated from ChapterGaugeComprehensiveFixing.lean — theorem BookProof.ChapterGaugeComprehensiveFixing.exists_physical_ne_agreeing_of_not_comprehensive
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeComprehensiveFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}
variable {X : Type*} [TopologicalSpace X] {G : Type*} [Group G] [MulAction G X]



open BookProof.ChapterGaugeIncompleteFixing

theorem BookProof.ChapterGaugeComprehensiveFixing.exists_physical_ne_agreeing_of_not_comprehensive
    (hS : ¬ IsComprehensiveGaugeFixing G S) :
    ∃ f f' : X → ℝ, IsPhysicalObservable G f ∧ IsPhysicalObservable G f' ∧
      (∀ s ∈ S, f s = f' s) ∧ f ≠ f' := by sorry
