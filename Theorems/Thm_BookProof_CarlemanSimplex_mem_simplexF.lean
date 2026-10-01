-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.mem_simplexF
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Definitions.Def_ChapterHermiteCarlemanEsa
import Definitions.Def_ChapterA4
open BookProof.HermiteCarleman

variable {d : ℕ}



open Finset

noncomputable section


theorem BookProof.CarlemanSimplex.mem_simplexF {d N : ℕ} {a : Fin d →₀ ℕ} : a ∈ simplexF d N ↔ deg a ≤ N := by sorry
