-- Generated from ChapterIrreversibleDynamics.lean — solution of BookProof.IrreversibleDynamics.finite_injective_iff_surjective
import Mathlib
import Definitions.Def_ChapterIrreversibleDynamics
open BookProof.IrreversibleDynamics




open MeasureTheory Function Set
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution {α : Type*} [Finite α] (f : α → α) :
    Function.Injective f ↔ Function.Surjective f := Finite.injective_iff_surjective
