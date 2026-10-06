-- Generated from ChapterEntropy.lean — solution of BookProof.ChapterEntropy.card_bijections
import Mathlib
import Definitions.Def_ChapterEntropy
open BookProof.ChapterEntropy




open Filter Asymptotics
open scoped Topology

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : Fintype.card (Equiv.Perm (Fin n)) = Nat.factorial n := by

  simp [Fintype.card_perm]
