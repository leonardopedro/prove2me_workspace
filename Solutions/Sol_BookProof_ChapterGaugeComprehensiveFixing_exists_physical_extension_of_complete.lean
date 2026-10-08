-- Generated from ChapterGaugeComprehensiveFixing.lean — solution of BookProof.ChapterGaugeComprehensiveFixing.exists_physical_extension_of_complete
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
import Theorems.Thm_BookProof_ChapterGaugeIncompleteFixing_exists_physical_extension
open BookProof.ChapterGaugeComprehensiveFixing




open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}

set_option maxHeartbeats 1000000 in
theorem solution
    (hcomp : IsComprehensiveGaugeFixing G S) (hcompl : IsCompleteGaugeFixing' G S)
    (h : X → ℝ) :
    ∃ f : X → ℝ, IsPhysicalObservable G f ∧ ∀ s ∈ S, f s = h s :=
  exists_physical_extension G hcomp h
      (fun s hsS t htS g hg => by rw [hcompl s hsS t htS g hg])
