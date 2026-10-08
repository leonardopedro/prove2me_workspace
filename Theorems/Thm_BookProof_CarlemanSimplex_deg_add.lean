-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.deg_add
import Definitions.Def_ChapterHermiteCarlemanEsa
import Definitions.Def_ChapterCarlemanTwoStep
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex



open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}


theorem BookProof.CarlemanSimplex.deg_add (a b : Fin d →₀ ℕ) : deg (a + b) = deg a + deg b := by sorry
