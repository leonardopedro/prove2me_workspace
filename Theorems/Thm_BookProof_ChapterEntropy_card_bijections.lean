-- Generated from ChapterEntropy.lean — theorem BookProof.ChapterEntropy.card_bijections
import Mathlib
import Definitions.Def_ChapterEntropy
open BookProof.ChapterEntropy



open Filter Asymptotics
open scoped Topology

theorem BookProof.ChapterEntropy.card_bijections (n : ℕ) : Fintype.card (Equiv.Perm (Fin n)) = Nat.factorial n := by sorry
