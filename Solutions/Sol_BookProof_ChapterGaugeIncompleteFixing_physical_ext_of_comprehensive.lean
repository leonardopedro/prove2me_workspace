-- Generated from ChapterGaugeIncompleteFixing.lean — solution of BookProof.ChapterGaugeIncompleteFixing.physical_ext_of_comprehensive
import Mathlib
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing



open scoped InnerProductSpace

variable {X : Type*}
variable (G : Type*) [Group G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution {S : Set X}
    (hS : IsComprehensiveGaugeFixing G S) {f f' : X → ℝ}
    (hf : IsPhysicalObservable G f) (hf_prime : IsPhysicalObservable G f')
    (hagree : ∀ s ∈ S, f s = f' s) : f = f' := by

  funext x
  obtain ⟨s, hsS, g, rfl⟩ := hS x
  rw [hf g s, hf_prime g s, hagree s hsS]
