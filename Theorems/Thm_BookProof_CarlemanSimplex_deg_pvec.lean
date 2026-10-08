-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.deg_pvec
import Definitions.Def_ChapterHermiteCarlemanEsa
import Definitions.Def_ChapterCarlemanTwoStep
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex



open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {u : (Fin d →₀ ℕ) → ℂ}

theorem BookProof.CarlemanSimplex.deg_pvec (i j : Fin d) : deg (pvec (d := d) i j) = 2 := by sorry
