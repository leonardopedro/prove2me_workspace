-- Generated from ChapterIrreversibleDynamics.lean — solution of BookProof.IrreversibleDynamics.finite_injective_imp_surjective
import Mathlib
import Definitions.Def_ChapterIrreversibleDynamics
import Theorems.Thm_BookProof_IrreversibleDynamics_finite_injective_iff_surjective
open BookProof.IrreversibleDynamics




open MeasureTheory Function Set
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution {α : Type*} [Finite α] {f : α → α}
    (hf : Function.Injective f) : Function.Surjective f := (finite_injective_iff_surjective f).1 hf
