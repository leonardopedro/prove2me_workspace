-- Generated from ChapterGaugeComprehensiveFixing.lean — solution of BookProof.ChapterGaugeComprehensiveFixing.orbitRepresentatives_isComprehensiveGaugeFixing
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
open BookProof.ChapterGaugeComprehensiveFixing




open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution :
    IsComprehensiveGaugeFixing G (orbitRepresentatives (X := X) G) := by

  intro x
  refine ⟨(Quotient.mk (MulAction.orbitRel G X) x).out, ⟨_, rfl⟩, ?_⟩
  have h : Quotient.mk (MulAction.orbitRel G X)
      (Quotient.mk (MulAction.orbitRel G X) x).out
      = Quotient.mk (MulAction.orbitRel G X) x := Quotient.out_eq _
  obtain ⟨g, hg⟩ := Quotient.exact h
  exact ⟨g⁻¹, by rw [← hg, inv_smul_smul]⟩
