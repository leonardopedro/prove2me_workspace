-- Generated from ChapterEntropy.lean — solution of BookProof.ChapterEntropy.card_selfMaps
import Mathlib
import Definitions.Def_ChapterEntropy
open BookProof.ChapterEntropy




open Filter Asymptotics
open scoped Topology

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : Fintype.card (Fin n → Fin n) = n ^ n := by

  simp
