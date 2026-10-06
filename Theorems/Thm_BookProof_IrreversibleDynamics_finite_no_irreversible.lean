-- Generated from ChapterIrreversibleDynamics.lean — theorem BookProof.IrreversibleDynamics.finite_no_irreversible
import Mathlib
import Definitions.Def_ChapterIrreversibleDynamics
open BookProof.IrreversibleDynamics



open MeasureTheory Function Set
open scoped ENNReal

theorem BookProof.IrreversibleDynamics.finite_no_irreversible {α : Type*} [Finite α] :
    ¬ ∃ f : α → α, Function.Injective f ∧ ¬ Function.Surjective f := by sorry
