-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.rcm_shiftm
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Definitions.Def_ChapterA4

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}



open Finset

noncomputable section


theorem BookProof.CarlemanSimplex.rcm_shiftm {a : Fin d →₀ ℕ} {i j : Fin d} (h : 1 ≤ a j) :
    rcm (shiftm a i j) j i = rcm a i j := by sorry
