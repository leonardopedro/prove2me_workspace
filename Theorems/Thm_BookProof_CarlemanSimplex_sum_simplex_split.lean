-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.sum_simplex_split
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Definitions.Def_ChapterA4

variable {d : ℕ}



open Finset

noncomputable section


theorem BookProof.CarlemanSimplex.sum_simplex_split (d N k : ℕ) (F : (Fin d →₀ ℕ) → ℂ) :
    ∑ a ∈ simplexF d N, F a = ∑ a ∈ sInn d N k, F a + ∑ a ∈ sBd d N k, F a := by sorry
