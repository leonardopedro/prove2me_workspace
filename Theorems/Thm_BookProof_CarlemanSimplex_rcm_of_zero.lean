-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.rcm_of_zero
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Definitions.Def_ChapterA4

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}



open Finset

noncomputable section


theorem BookProof.CarlemanSimplex.rcm_of_zero {a : Fin d →₀ ℕ} {i j : Fin d} (h : a j = 0) : rcm a i j = 0 := by sorry
