-- Generated from ChapterGaugeIncompleteFixing.lean — solution of BookProof.ChapterGaugeIncompleteFixing.isPhysicalObservable_iff_factors
import Mathlib
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing



open scoped InnerProductSpace

variable {X : Type*}
variable (G : Type*) [Group G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution (f : X → ℝ) :
    IsPhysicalObservable G f ↔
      ∃ F : Quotient (MulAction.orbitRel G X) → ℝ,
        ∀ x : X, f x = F (Quotient.mk (MulAction.orbitRel G X) x) := by

  constructor
  · intro hf
    refine ⟨Quotient.lift f ?_, fun x => rfl⟩
    intro a b hab
    obtain ⟨g, hg⟩ := hab
    simp only at hg
    rw [← hg, hf g b]
  · rintro ⟨F, hF⟩ g x
    rw [hF (g • x), hF x]
    congr 1
    exact Quotient.sound (MulAction.mem_orbit x g)
