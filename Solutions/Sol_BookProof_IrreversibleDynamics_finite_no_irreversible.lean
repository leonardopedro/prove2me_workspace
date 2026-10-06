-- Generated from ChapterIrreversibleDynamics.lean — solution of BookProof.IrreversibleDynamics.finite_no_irreversible
import Mathlib
import Definitions.Def_ChapterIrreversibleDynamics
import Theorems.Thm_BookProof_IrreversibleDynamics_finite_injective_imp_surjective
open BookProof.IrreversibleDynamics




open MeasureTheory Function Set
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution {α : Type*} [Finite α] :
    ¬ ∃ f : α → α, Function.Injective f ∧ ¬ Function.Surjective f := by

  rintro ⟨f, hinj, hnsurj⟩
  exact hnsurj (finite_injective_imp_surjective hinj)
