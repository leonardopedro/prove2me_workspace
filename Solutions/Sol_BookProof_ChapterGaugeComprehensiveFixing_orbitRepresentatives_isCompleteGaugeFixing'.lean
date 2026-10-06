-- Generated from ChapterGaugeComprehensiveFixing.lean — solution of BookProof.ChapterGaugeComprehensiveFixing.orbitRepresentatives_isCompleteGaugeFixing'
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
open BookProof.ChapterGaugeComprehensiveFixing




open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution :
    IsCompleteGaugeFixing' G (orbitRepresentatives (X := X) G) := by

  rintro s ⟨c, rfl⟩ t ⟨d, rfl⟩ g hg
  dsimp only at hg ⊢
  have hg' : g⁻¹ • d.out = c.out := by rw [← hg, inv_smul_smul]
  have hmk : Quotient.mk (MulAction.orbitRel G X) c.out
      = Quotient.mk (MulAction.orbitRel G X) d.out :=
    Quotient.sound ⟨g⁻¹, hg'⟩
  rw [Quotient.out_eq, Quotient.out_eq] at hmk
  rw [hmk]
