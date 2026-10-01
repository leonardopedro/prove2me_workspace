-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.tsub_add_cancel_of_le'
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

theorem BookProof.CarlemanSimplex.tsub_add_cancel_of_le' {P a : Fin d →₀ ℕ} (h : P ≤ a) : a - P + P = a := by sorry
