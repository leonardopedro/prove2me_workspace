-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.mem_simplexF
import Definitions.Def_ChapterCarlemanTwoStep
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Definitions.Def_ChapterHermiteCarlemanEsa
open BookProof.HermiteCarleman
open BookProof.CarlemanSimplex



open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}


theorem BookProof.CarlemanSimplex.mem_simplexF {d N : ℕ} {a : Fin d →₀ ℕ} : a ∈ simplexF d N ↔ deg a ≤ N := by sorry
