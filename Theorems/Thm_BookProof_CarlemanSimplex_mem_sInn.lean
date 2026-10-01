-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.mem_sInn
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Definitions.Def_ChapterA4

variable {d : ℕ}



open Finset

noncomputable section


theorem BookProof.CarlemanSimplex.mem_sInn {d N k : ℕ} {a : Fin d →₀ ℕ} : a ∈ sInn d N k ↔ deg a + k ≤ N := by sorry
