-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.mem_sBd
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Definitions.Def_ChapterA4

variable {d : ℕ}



open Finset

noncomputable section


theorem BookProof.CarlemanSimplex.mem_sBd {d N k : ℕ} {a : Fin d →₀ ℕ} :
    a ∈ sBd d N k ↔ deg a ≤ N ∧ N < deg a + k := by sorry
