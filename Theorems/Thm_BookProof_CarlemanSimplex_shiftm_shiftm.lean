-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.shiftm_shiftm
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Definitions.Def_ChapterA4

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}



open Finset

noncomputable section


theorem BookProof.CarlemanSimplex.shiftm_shiftm {a : Fin d →₀ ℕ} {i j : Fin d} (h : 1 ≤ a j) :
    shiftm (shiftm a i j) j i = a := by sorry
