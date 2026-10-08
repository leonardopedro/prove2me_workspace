-- Generated from ChapterGaugeComprehensiveFixing.lean — theorem BookProof.ChapterGaugeComprehensiveFixing.existsUnique_mem_of_complete_comprehensive
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeComprehensiveFixing



open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}

theorem BookProof.ChapterGaugeComprehensiveFixing.existsUnique_mem_of_complete_comprehensive
    (hcomp : IsComprehensiveGaugeFixing G S) (hcompl : IsCompleteGaugeFixing' G S)
    (x : X) : ∃! s : X, s ∈ S ∧ ∃ g : G, g • s = x := by sorry
