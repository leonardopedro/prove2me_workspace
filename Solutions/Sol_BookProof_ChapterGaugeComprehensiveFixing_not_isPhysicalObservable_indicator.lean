-- Generated from ChapterGaugeComprehensiveFixing.lean — solution of BookProof.ChapterGaugeComprehensiveFixing.not_isPhysicalObservable_indicator
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
open BookProof.ChapterGaugeComprehensiveFixing




open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial G] [Nonempty X]
    (hcomp : IsComprehensiveGaugeFixing G S) (hcompl : IsCompleteGaugeFixing' G S)
    (hfree : MovesEveryPointOfSpectrum G X) :
    ¬ IsPhysicalObservable G (S.indicator (fun _ => (1 : ℝ))) := by

  intro hphys
  obtain ⟨x⟩ := ‹Nonempty X›
  obtain ⟨s, hsS, g, -⟩ := hcomp x
  obtain ⟨h, hh⟩ := exists_ne (1 : G)
  have hnot : h • s ∉ S := fun hmem => hfree h hh s (hcompl s hsS (h • s) hmem h rfl).symm
  have hval := hphys h s
  rw [Set.indicator_of_notMem hnot, Set.indicator_of_mem hsS] at hval
  exact one_ne_zero hval.symm
