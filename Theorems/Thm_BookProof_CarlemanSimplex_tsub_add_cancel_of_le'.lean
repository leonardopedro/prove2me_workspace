-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.tsub_add_cancel_of_le'
import Definitions.Def_ChapterHermiteCarlemanEsa
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex

variable {d : ℕ}



open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section


theorem BookProof.CarlemanSimplex.tsub_add_cancel_of_le' {P a : Fin d →₀ ℕ} (h : P ≤ a) : a - P + P = a := by sorry
