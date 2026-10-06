-- Generated from ChapterGaugeComprehensiveFixing.lean — theorem BookProof.ChapterGaugeComprehensiveFixing.physical_ext_iff_comprehensive
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeComprehensiveFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}
variable {X : Type*} [TopologicalSpace X] {G : Type*} [Group G] [MulAction G X]



open BookProof.ChapterGaugeIncompleteFixing

theorem BookProof.ChapterGaugeComprehensiveFixing.physical_ext_iff_comprehensive :
    (∀ f f' : X → ℝ, IsPhysicalObservable G f → IsPhysicalObservable G f' →
        (∀ s ∈ S, f s = f' s) → f = f') ↔ IsComprehensiveGaugeFixing G S := by sorry
