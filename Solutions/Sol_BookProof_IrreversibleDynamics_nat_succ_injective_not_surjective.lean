-- Generated from ChapterIrreversibleDynamics.lean — solution of BookProof.IrreversibleDynamics.nat_succ_injective_not_surjective
import Mathlib
import Definitions.Def_ChapterIrreversibleDynamics
open BookProof.IrreversibleDynamics




open MeasureTheory Function Set
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution :
    Function.Injective Nat.succ ∧ ¬ Function.Surjective Nat.succ :=
  ⟨Nat.succ_injective, by
      intro h; obtain ⟨n, hn⟩ := h 0; exact Nat.succ_ne_zero n hn⟩
