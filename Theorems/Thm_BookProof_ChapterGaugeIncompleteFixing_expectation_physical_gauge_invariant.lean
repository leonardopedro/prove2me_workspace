-- Generated from ChapterGaugeIncompleteFixing.lean — theorem BookProof.ChapterGaugeIncompleteFixing.expectation_physical_gauge_invariant
import Mathlib
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*}
variable (G : Type*) [Group G] [MulAction G X]
variable {G : Type*} [Group G]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


open scoped InnerProductSpace

theorem BookProof.ChapterGaugeIncompleteFixing.expectation_physical_gauge_invariant {U : G → (H →L[ℂ] H)}
    (hU : IsGaugeUnitaryFamily U) {A : H →L[ℂ] H} (hA : IsPhysicalOperator U A)
    (g : G) (Ψ : H) :
    ⟪U g Ψ, A (U g Ψ)⟫_ℂ = ⟪Ψ, A Ψ⟫_ℂ := by sorry
