-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.lcp_vanish
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Definitions.Def_ChapterA4

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}



open Finset

noncomputable section


theorem BookProof.CarlemanSimplex.lcp_vanish (i j : Fin d) (a : Fin d →₀ ℕ) (h : ¬ pvec i j ≤ a) : lcp a i j = 0 := by sorry
