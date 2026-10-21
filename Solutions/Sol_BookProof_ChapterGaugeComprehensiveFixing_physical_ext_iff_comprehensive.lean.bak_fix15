-- Generated from ChapterGaugeComprehensiveFixing.lean — solution of BookProof.ChapterGaugeComprehensiveFixing.physical_ext_iff_comprehensive
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
import Theorems.Thm_BookProof_ChapterGaugeComprehensiveFixing_exists_physical_ne_agreeing_of_not_comprehensive
import Theorems.Thm_BookProof_ChapterGaugeIncompleteFixing_physical_ext_of_comprehensive
open BookProof.ChapterGaugeComprehensiveFixing




open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}
variable {X : Type*} [TopologicalSpace X] {G : Type*} [Group G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution :
    (∀ f f' : X → ℝ, IsPhysicalObservable G f → IsPhysicalObservable G f' →
        (∀ s ∈ S, f s = f' s) → f = f') ↔ IsComprehensiveGaugeFixing G S := by

  constructor
  · intro hext
    by_contra hS
    obtain ⟨f, f', hf, hf_prime, hagree, hne⟩ :=
      exists_physical_ne_agreeing_of_not_comprehensive hS
    exact hne (hext f f' hf hf_prime hagree)
  · intro hS f f' hf hf_prime hagree
    exact physical_ext_of_comprehensive G hS hf hf_prime hagree
