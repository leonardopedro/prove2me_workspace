-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.tsub_add_cancel_of_le'
import Definitions.Def_ChapterHermiteCarlemanEsa
import Definitions.Def_ChapterCarlemanTwoStep
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex



open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}


theorem BookProof.CarlemanSimplex.tsub_add_cancel_of_le_prime {P a : Fin d →₀ ℕ} (h : P ≤ a) : a - P + P = a := by sorry
