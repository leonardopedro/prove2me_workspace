-- Generated from ChapterGaugeIncompleteFixing.lean — theorem BookProof.ChapterGaugeIncompleteFixing.no_gauge_invariant_unit_vector_of_free
import Mathlib
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing


open scoped InnerProductSpace

variable {X : Type*}
variable (G : Type*) [Group G] [MulAction G X]
variable {G : Type*} [Group G]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.ChapterGaugeIncompleteFixing.no_gauge_invariant_unit_vector_of_free [Nontrivial G]
    {U : G → (H →L[ℂ] H)}
    (hfree : ∀ g : G, g ≠ 1 → ∀ Ψ : H, Ψ ≠ 0 → U g Ψ ≠ Ψ) :
    ¬ ∃ Ψ : H, ‖Ψ‖ = 1 ∧ ∀ g : G, U g Ψ = Ψ := by sorry
