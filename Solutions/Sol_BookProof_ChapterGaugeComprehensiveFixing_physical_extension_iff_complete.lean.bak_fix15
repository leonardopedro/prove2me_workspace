-- Generated from ChapterGaugeComprehensiveFixing.lean — solution of BookProof.ChapterGaugeComprehensiveFixing.physical_extension_iff_complete
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
import Theorems.Thm_BookProof_ChapterGaugeComprehensiveFixing_exists_not_extendable_of_not_complete
open BookProof.ChapterGaugeComprehensiveFixing




open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}
variable {X : Type*} [TopologicalSpace X] {G : Type*} [Group G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution :
    (∀ h : X → ℝ, ∃ f : X → ℝ, IsPhysicalObservable G f ∧ ∀ s ∈ S, f s = h s) ↔
      IsCompleteGaugeFixing' G S := by

  constructor
  · intro hext
    by_contra hS
    obtain ⟨h, hh⟩ := exists_not_extendable_of_not_complete hS
    exact hh (hext h)
  · intro hS h
    classical
    have key : ∀ c : Quotient (MulAction.orbitRel G X), ∃ r : ℝ,
        ∀ s ∈ S, Quotient.mk (MulAction.orbitRel G X) s = c → r = h s := by
      intro c
      by_cases hc : ∃ s, s ∈ S ∧ Quotient.mk (MulAction.orbitRel G X) s = c
      · obtain ⟨s₀, hs₀S, hs₀c⟩ := hc
        refine ⟨h s₀, fun s hsS hsc => ?_⟩
        have hmk : Quotient.mk (MulAction.orbitRel G X) s
            = Quotient.mk (MulAction.orbitRel G X) s₀ := by rw [hsc, hs₀c]
        obtain ⟨g, hg⟩ := Quotient.exact hmk
        rw [hS s₀ hs₀S s hsS g hg]
      · exact ⟨0, fun s hsS hsc => absurd ⟨s, hsS, hsc⟩ hc⟩
    choose F hF using key
    refine ⟨fun x => F (Quotient.mk (MulAction.orbitRel G X) x), fun g x => ?_,
      fun s hsS => hF _ s hsS rfl⟩
    have hq : Quotient.mk (MulAction.orbitRel G X) (g • x)
        = Quotient.mk (MulAction.orbitRel G X) x :=
      Quotient.sound (MulAction.mem_orbit x g)
    simp only [hq]
