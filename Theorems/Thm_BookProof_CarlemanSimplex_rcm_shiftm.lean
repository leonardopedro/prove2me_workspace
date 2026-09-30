-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.rcm_shiftm
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex










open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

















variable {u : (Fin d →₀ ℕ) → ℂ}

theorem BookProof.CarlemanSimplex.rcm_shiftm {a : Fin d →₀ ℕ} {i j : Fin d} (h : 1 ≤ a j) :
    rcm (shiftm a i j) j i = rcm a i j := by sorry
