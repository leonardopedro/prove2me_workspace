-- Generated from ChapterEntropy.lean — solution of BookProof.ChapterEntropy.exists_injective_not_surjective
import Mathlib
import Definitions.Def_ChapterEntropy
open BookProof.ChapterEntropy




open Filter Asymptotics
open scoped Topology

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ f : ℕ → ℕ, Function.Injective f ∧ ¬ Function.Surjective f :=
  ⟨Nat.succ, Nat.succ_injective, fun h => by
      obtain ⟨x, hx⟩ := h 0
      exact (Nat.succ_ne_zero x) hx⟩
