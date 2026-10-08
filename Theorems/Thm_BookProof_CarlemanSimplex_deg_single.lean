-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.deg_single
import Definitions.Def_ChapterHermiteCarlemanEsa
import Definitions.Def_ChapterCarlemanTwoStep
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex



open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}


theorem BookProof.CarlemanSimplex.deg_single (i : Fin d) (k : ℕ) : deg (Finsupp.single i k) = k := by sorry
