-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.shiftm_shiftm
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}
variable {lam : (Fin d →₀ ℕ) → ℝ} {w : Fin d → ℂ} {W M : Fin d → Fin d → ℂ} {z : ℂ}



open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

theorem BookProof.CarlemanSimplex.shiftm_shiftm {a : Fin d →₀ ℕ} {i j : Fin d} (h : 1 ≤ a j) :
    shiftm (shiftm a i j) j i = a := by sorry
