-- Generated from ChapterIrreversibleDynamics.lean — theorem BookProof.IrreversibleDynamics.finite_injective_imp_surjective
import Mathlib
import Definitions.Def_ChapterIrreversibleDynamics
open BookProof.IrreversibleDynamics



open MeasureTheory Function Set
open scoped ENNReal

theorem BookProof.IrreversibleDynamics.finite_injective_imp_surjective {α : Type*} [Finite α] {f : α → α}
    (hf : Function.Injective f) : Function.Surjective f := by sorry
