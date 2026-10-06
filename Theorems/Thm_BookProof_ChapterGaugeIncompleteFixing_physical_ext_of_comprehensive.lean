-- Generated from ChapterGaugeIncompleteFixing.lean — theorem BookProof.ChapterGaugeIncompleteFixing.physical_ext_of_comprehensive
import Mathlib
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*}
variable (G : Type*) [Group G] [MulAction G X]


open scoped InnerProductSpace

theorem BookProof.ChapterGaugeIncompleteFixing.physical_ext_of_comprehensive {S : Set X}
    (hS : IsComprehensiveGaugeFixing G S) {f f' : X → ℝ}
    (hf : IsPhysicalObservable G f) (hf' : IsPhysicalObservable G f')
    (hagree : ∀ s ∈ S, f s = f' s) : f = f' := by sorry
