-- Generated from ChapterEntropy.lean — theorem BookProof.ChapterEntropy.card_selfMaps
import Mathlib
import Definitions.Def_ChapterEntropy
open BookProof.ChapterEntropy



open Filter Asymptotics
open scoped Topology

theorem BookProof.ChapterEntropy.card_selfMaps (n : ℕ) : Fintype.card (Fin n → Fin n) = n ^ n := by sorry
