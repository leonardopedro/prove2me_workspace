-- Generated from ChapterGaugeComprehensiveFixing.lean — solution of BookProof.ChapterGaugeComprehensiveFixing.existsUnique_physical_extension_of_complete
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
import Theorems.Thm_BookProof_ChapterGaugeComprehensiveFixing_exists_physical_extension_of_complete
open BookProof.ChapterGaugeComprehensiveFixing




open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}

set_option maxHeartbeats 1000000 in
theorem solution
    (hcomp : IsComprehensiveGaugeFixing G S) (hcompl : IsCompleteGaugeFixing' G S)
    (h : X → ℝ) :
    ∃! f : X → ℝ, IsPhysicalObservable G f ∧ ∀ s ∈ S, f s = h s := by

  obtain ⟨f, hf, hfS⟩ := exists_physical_extension_of_complete hcomp hcompl h
  refine ⟨f, ⟨hf, hfS⟩, ?_⟩
  rintro f' ⟨hf', hf'S⟩
  exact physical_ext_of_comprehensive G hcomp hf' hf (fun s hs => by rw [hf'S s hs, hfS s hs])
