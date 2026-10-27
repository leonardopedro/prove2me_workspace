-- Generated from ChapterGaugeComprehensiveFixing.lean — solution of BookProof.ChapterGaugeComprehensiveFixing.exists_not_extendable_of_not_complete
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
open BookProof.ChapterGaugeComprehensiveFixing




open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}
variable {X : Type*} [TopologicalSpace X] {G : Type*} [Group G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution (hS : ¬ IsCompleteGaugeFixing' G S) :
    ∃ h : X → ℝ, ¬ ∃ f : X → ℝ, IsPhysicalObservable G f ∧ ∀ s ∈ S, f s = h s := by

  classical
  rw [IsCompleteGaugeFixing'] at hS
  push_neg at hS
  obtain ⟨s, hsS, t, htS, g, hgst, hst⟩ := hS
  refine ⟨({s} : Set X).indicator (fun _ => (1 : ℝ)), ?_⟩
  rintro ⟨f, hf, hfS⟩
  have hfs : f s = 1 := by
    rw [hfS s hsS, Set.indicator_of_mem (Set.mem_singleton s)]
  have hft : f t = 0 := by
    rw [hfS t htS, Set.indicator_of_notMem (by simpa [eq_comm] using hst)]
  rw [← hgst, hf g s, hfs] at hft
  exact one_ne_zero hft
