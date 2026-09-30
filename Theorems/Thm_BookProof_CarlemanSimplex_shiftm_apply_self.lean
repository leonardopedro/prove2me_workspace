-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.shiftm_apply_self
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex










open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

















variable {u : (Fin d →₀ ℕ) → ℂ}

theorem BookProof.CarlemanSimplex.shiftm_apply_self {a : Fin d →₀ ℕ} {i j : Fin d} :
    (shiftm a i j) i = (a - Finsupp.single j 1 : Fin d →₀ ℕ) i + 1 := by sorry
