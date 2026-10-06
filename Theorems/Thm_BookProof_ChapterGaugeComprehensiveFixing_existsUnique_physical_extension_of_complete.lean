-- Generated from ChapterGaugeComprehensiveFixing.lean — theorem BookProof.ChapterGaugeComprehensiveFixing.existsUnique_physical_extension_of_complete
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeComprehensiveFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}



open BookProof.ChapterGaugeIncompleteFixing

theorem BookProof.ChapterGaugeComprehensiveFixing.existsUnique_physical_extension_of_complete
    (hcomp : IsComprehensiveGaugeFixing G S) (hcompl : IsCompleteGaugeFixing' G S)
    (h : X → ℝ) :
    ∃! f : X → ℝ, IsPhysicalObservable G f ∧ ∀ s ∈ S, f s = h s := by sorry
