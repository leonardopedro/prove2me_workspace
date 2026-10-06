-- Generated from ChapterGaugeIncompleteFixing.lean — solution of BookProof.ChapterGaugeIncompleteFixing.isPhysicalOperator_iff_mem_centralizer
import Mathlib
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing



open scoped InnerProductSpace

variable {X : Type*}
variable (G : Type*) [Group G] [MulAction G X]
variable {G : Type*} [Group G]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (U : G → (H →L[ℂ] H))
    (A : H →L[ℂ] H) :
    IsPhysicalOperator U A ↔ A ∈ Subalgebra.centralizer ℂ (Set.range U) := by

  constructor
  · rintro hA _ ⟨g, rfl⟩
    exact (hA g).symm
  · intro hA g
    exact (hA (U g) ⟨g, rfl⟩).symm
