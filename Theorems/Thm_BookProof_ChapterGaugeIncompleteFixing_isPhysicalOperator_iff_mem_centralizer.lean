-- Generated from ChapterGaugeIncompleteFixing.lean — theorem BookProof.ChapterGaugeIncompleteFixing.isPhysicalOperator_iff_mem_centralizer
import Mathlib
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*}
variable (G : Type*) [Group G] [MulAction G X]
variable {G : Type*} [Group G]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


open scoped InnerProductSpace

theorem BookProof.ChapterGaugeIncompleteFixing.isPhysicalOperator_iff_mem_centralizer (U : G → (H →L[ℂ] H))
    (A : H →L[ℂ] H) :
    IsPhysicalOperator U A ↔ A ∈ Subalgebra.centralizer ℂ (Set.range U) := by sorry
