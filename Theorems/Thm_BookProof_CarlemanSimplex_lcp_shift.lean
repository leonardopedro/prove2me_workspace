-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.lcp_shift
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Definitions.Def_ChapterA4

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}



open Finset

noncomputable section


theorem BookProof.CarlemanSimplex.lcp_shift (i j : Fin d) (a : Fin d →₀ ℕ) :
    lcp (a + pvec i j) i j = rcp a i j := by sorry
