-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.rcp_nonneg
import Definitions.Def_ChapterHermiteCarlemanEsa
import Definitions.Def_ChapterCarlemanTwoStep
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}



open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section


theorem BookProof.CarlemanSimplex.rcp_nonneg (a : Fin d →₀ ℕ) (i j : Fin d) : 0 ≤ rcp a i j := by sorry
