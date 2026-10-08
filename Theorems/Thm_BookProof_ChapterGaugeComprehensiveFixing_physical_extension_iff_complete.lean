-- Generated from ChapterGaugeComprehensiveFixing.lean — theorem BookProof.ChapterGaugeComprehensiveFixing.physical_extension_iff_complete
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeComprehensiveFixing



open BookProof.ChapterGaugeIncompleteFixing


variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}

theorem BookProof.ChapterGaugeComprehensiveFixing.physical_extension_iff_complete :
    (∀ h : X → ℝ, ∃ f : X → ℝ, IsPhysicalObservable G f ∧ ∀ s ∈ S, f s = h s) ↔
      IsCompleteGaugeFixing' G S := by sorry
